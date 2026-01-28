# Contributing to Geode Zig Client

We'd love to accept your patches and contributions to this project through the
process of creating a [merge request][] (**MR**). This document details the
process of submitting an MR so that it can be reviewed and merged into the
codebase. It also contains some guidelines for writing good commits, reporting
issues, and guidelines for project maintainers.

---

## Reporting issues

Bugs, feature requests, and development-related questions should be directed to
the specific project's issue tracker or discussion board.

### Bugs

If reporting a bug, please submit an issue and provide as much context as
possible such as your operating system, architecture, library release version,
Zig version, and anything else that might be relevant to the bug.

Fill out as much information as possible in the form provided by the issue
template.

#### SECURITY BUGS

We take security bugs ***VERY*** seriously!

Please promptly report security related bugs to <security@devnw.com>. Please
follow [responsible disclosure guidelines][] when publicizing any security related
information, ensuring that maintainers are aware of the issue and are able to
address it promptly.

Please include:

1. Information about the vulnerability
2. Associated CVEs (if any)
3. Affected release(s)
4. Affected package(s)

### Feature Requests

For feature requests, please explain what you're trying to do, and
how the requested feature would help you do that.

Security related bugs can either be reported in the issue tracker, or if they
are more sensitive, emailed to <security@devnw.com>.

[responsible disclosure guidelines]: https://cheatsheetseries.owasp.org/cheatsheets/Vulnerability_Disclosure_Cheat_Sheet.html

---

## Development Setup

1. Clone the repository:

   ```bash
   git clone https://gitlab.com/devnw/codepros/geode/geode-client-zig.git
   cd geode-client-zig
   ```

2. Build, test, and format:

   ```bash
   zig build
   zig build test --summary all
   zig fmt src/
   ```

---

## Submitting a Merge Request

  1. It's generally best to start by opening a new issue describing the bug or
     feature you're intending to fix. Even if you think it's relatively minor,
     it's helpful to know what people are working on. Mention in the initial
     issue that you are planning to work on that bug or feature so that it can
     be assigned to you.

  2. Follow the normal process of [forking][] the project, and setup a new
     branch to work in. It's important that each group of changes be done in
     separate branches in order to ensure that a merge request only includes the
     commits related to that bug or feature.

  3. Before committing, ensure your code is properly formatted by running
     `zig fmt src/`. This ensures consistency throughout the project.

  4. Any significant changes should almost always be accompanied by tests. The
     project already has good test coverage, so look at some of the existing
     tests if you're unsure how to go about it.

  5. Do your best to have [well-formed commit messages][] for each change.
     This provides consistency throughout the project, and ensures that commit
     messages are able to be formatted properly by various git tools.

  6. Finally, push the commits to your fork and submit a [merge request][].
     **NOTE:** It is recommended that you [squash][] your commits into a single
       commit before submitting a merge request.

     * When submitting a merge request, please include a [link to the issue][]
       that you're submitting a merge request for. This will help us to track the
       progress of the issue.

[forking]: https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html
[well-formed commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[squash]: http://git-scm.com/book/en/Git-Tools-Rewriting-History#Squashing-Commits
[merge request]: https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html
[link to the issue]: https://docs.gitlab.com/ee/user/project/issues/crosslinking_issues.html

---

## Code Organization

---

## Maintainer's Guide

(These notes are mostly only for people merging in merge requests.)

It is the responsibility of the maintainer to ensure that the code is passing
all checks and tests. The maintainer should also ensure that the code is
consistent with the project's code style and documentation. The maintainer
should also ensure that the code is well-documented and tested before merging
in a merge request.
