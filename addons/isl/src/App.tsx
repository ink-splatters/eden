/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import type {RepositoryError} from './types';

import {CommandHistoryAndProgress} from './CommandHistoryAndProgress';
import {CommitInfoSidebar} from './CommitInfoView/CommitInfoView';
import {CommitTreeList} from './CommitTreeList';
import {ComparisonViewModal} from './ComparisonView/ComparisonViewModal';
import {EmptyState} from './EmptyState';
import {ErrorBoundary, ErrorNotice} from './ErrorNotice';
import {ISLCommandContext, useCommand} from './ISLShortcuts';
import {TopBar} from './TopBar';
import {TopLevelErrors} from './TopLevelErrors';
import {tracker} from './analytics';
import {islDrawerState} from './drawerState';
import {GettingStartedModal} from './gettingStarted/GettingStartedModal';
import {I18nSupport, t, T} from './i18n';
import platform from './platform';
import {useMainContentWidth} from './responsive';
import {repositoryInfo} from './serverAPIState';
import {ThemeRoot} from './theme';
import {ModalContainer} from './useModal';
import {VSCodeButton} from '@vscode/webview-ui-toolkit/react';
import React from 'react';
import {RecoilRoot, useRecoilValue, useSetRecoilState} from 'recoil';
import {ContextMenus} from 'shared/ContextMenu';
import {Drawers} from 'shared/Drawers';
import {Icon} from 'shared/Icon';
import {useThrottledEffect} from 'shared/hooks';

import './index.css';

export default function App() {
  return (
    <React.StrictMode>
      <I18nSupport>
        <RecoilRoot>
          <ThemeRoot>
            <ISLCommandContext>
              <ErrorBoundary>
                <ISLDrawers />
                <div className="tooltip-root-container" data-testid="tooltip-root-container" />
                <GettingStartedModal />
                <ComparisonViewModal />
                <ModalContainer />
                <ContextMenus />
              </ErrorBoundary>
            </ISLCommandContext>
          </ThemeRoot>
        </RecoilRoot>
      </I18nSupport>
    </React.StrictMode>
  );
}

function ISLDrawers() {
  const setDrawerState = useSetRecoilState(islDrawerState);
  useCommand('ToggleSidebar', () => {
    setDrawerState(state => ({
      ...state,
      right: {...state.right, collapsed: !state.right.collapsed},
    }));
  });

  return (
    <Drawers
      drawerState={islDrawerState}
      rightLabel={
        <>
          <Icon icon="edit" />
          <T>Commit Info</T>
        </>
      }
      right={<CommitInfoSidebar />}
      errorBoundary={ErrorBoundary}>
      <MainContent />
      <CommandHistoryAndProgress />
    </Drawers>
  );
}

function MainContent() {
  const repoInfo = useRecoilValue(repositoryInfo);

  const ref = useMainContentWidth();

  return (
    <div className="main-content-area" ref={ref}>
      <TopBar />
      <TopLevelErrors />
      {repoInfo != null && repoInfo.type !== 'success' ? (
        <ISLNullState repoError={repoInfo} />
      ) : (
        <CommitTreeList />
      )}
    </div>
  );
}

function ISLNullState({repoError}: {repoError: RepositoryError}) {
  useThrottledEffect(
    () => {
      if (repoError != null) {
        switch (repoError.type) {
          case 'cwdNotARepository':
            tracker.track('UIEmptyState', {extras: {cwd: repoError.cwd}, errorName: 'InvalidCwd'});
            break;
          case 'invalidCommand':
            tracker.track('UIEmptyState', {
              extras: {command: repoError.command},
              errorName: 'InvalidCommand',
            });
            break;
          case 'unknownError':
            tracker.error('UIEmptyState', 'RepositoryError', repoError.error);
            break;
        }
      }
    },
    1_000,
    [repoError],
  );
  let content;
  if (repoError != null) {
    if (repoError.type === 'cwdNotARepository') {
      content = (
        <EmptyState>
          <div>
            <T>Not a valid repository</T>
          </div>
          <p>
            <T replace={{$cwd: <code>{repoError.cwd}</code>}}>
              $cwd is not a valid Sapling repository. Clone or init a repository to use ISL.
            </T>
          </p>
        </EmptyState>
      );
    } else if (repoError.type === 'invalidCommand') {
      content = (
        <ErrorNotice
          title={<T>Invalid Sapling command. Is Sapling installed correctly?</T>}
          error={
            new Error(t('Command "$cmd" was not found.', {replace: {$cmd: repoError.command}}))
          }
          buttons={[
            <VSCodeButton
              key="help-button"
              appearance="secondary"
              onClick={e => {
                platform.openExternalLink('https://sapling-scm.com/docs/introduction/installation');
                e.preventDefault();
                e.stopPropagation();
              }}>
              <T>See installation docs</T>
            </VSCodeButton>,
          ]}
        />
      );
    } else {
      content = <ErrorNotice title={<T>Something went wrong</T>} error={repoError.error} />;
    }
  }

  return <div className="empty-app-state">{content}</div>;
}
