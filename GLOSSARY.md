# Glossary

The words prx uses in its UI, manpage, and code. Each word has one meaning.
Use them exactly as defined here.

**sync**
: Fetch the list of PRs for the current filters (repos, states, time window)
  and upsert them into the list. Runs at start-up, on `Esc`, on the auto-sync
  schedule (`Tab` toggles it), and when a filter widens the scope. The top bar
  shows `last sync 42s ago`. A sync is either a full sync or a delta sync, per
  repo and state.

**full sync**
: A sync that pages down to the time window's cutoff. OPEN and CLOSED always
  get a full sync, because CI results and merge state change without bumping a
  PR's `updatedAt`, and closed PRs can reopen. MERGED gets a full sync when the
  cache does not cover the window yet.

**delta sync**
: A sync that stops paging at the watermark. Only MERGED uses it: merged PRs
  are final, so anything not updated since the last sync is taken from the
  cache.

**refresh**
: Fetch one PR's live state. `Space` refreshes the selected PR, the waiting
  schedule (`w`) refreshes watched PRs, and `M` refreshes a PR before the merge
  dialog. A refresh never changes which PRs are in the list.

**restore**
: Load saved local state at start-up: filters and waiting marks from
  `state.json`, and the PR list from the cache. Restored rows show at once;
  the top bar reads `restored 2h ago` until the first sync finishes.

**cache**
: One JSON file per repository in `${XDG_CACHE_HOME:-~/.cache}/prx/`, named
  by the SHA-1 of `owner/repo`. It holds raw GraphQL PR nodes, so rows are
  rebuilt with the current code and author settings on restore. Disposable:
  `prx --clear-cache` or `clear cache` in the `,` settings modal. `--plain` and
  `--json` never use it.

**watermark**
: Per repo and state: the start time of the last successful sync, minus 5
  minutes of margin. A delta sync stops at it.

**covered-since**
: Per repo and state: the oldest `updatedAt` that a sync has fetched down to.
  A delta sync is only valid when covered-since is at or before the current
  window's cutoff; otherwise that state gets a full sync.

**time window**
: How far back the list reaches: PRs updated in the last day, week, or month
  (`l` cycles it). Filters on `updatedAt`. Its **cutoff** is the oldest
  `updatedAt` it admits.

**auto-sync**
: The sync that repeats on a timer (`refresh` config key, default 300
  seconds). `Tab` toggles it.

**waiting**
: A mark on one PR (`w`). The **waiting schedule** refreshes waiting PRs on
  the `refresh_waiting` interval, on top of the sync. The mark clears itself
  once the PR is merged or closed. The PR number turns purple while it is set.

**action**
: The next move prx suggests for a PR, shown in the ACTION column and the
  detail card (`review`, `update`, `merge`, `land`, `stack`, `hold`, `blocked`,
  `wait`, and so on). `M` does what the action says.

**stack**
: PRs chained by base branch: each PR's base branch is the head branch of the
  PR below it. The **root** is the bottom PR. Each PR in a stack is a
  **layer**. A **plain stack** is chained only by base branches; a **native
  stack** is linked as a GitHub stack. Also the `stack` action: link a plain
  stack into a native one with gh-stack.

**chain**
: The layers of one stack from bottom to top, as `M` walks them on GitHub.
  Includes PRs hidden by the time window or filters.

**tree**
: A branch with two or more open PRs based on it. A stack can't hold a tree,
  so prx refuses to link one.

**land**
: Merge a whole native stack in one go. The `land` action shows only when
  every unmerged layer is ready and none is BLOCKED.

Don't use synonyms for these words: not "refetch" for refresh, not "reload"
for sync.

Config keys keep their historic names: `refresh` is the auto-sync interval,
and `refresh_waiting` is the waiting schedule's refresh interval.
