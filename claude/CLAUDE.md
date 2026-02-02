# CLAUDE.md

## AI Guidance

* To save main context space, for code searches, inspections, troubleshooting or analysis, use code-searcher subagent where appropriate - giving the subagent full context background for the task(s) you assign it.
* After receiving tool results, carefully reflect on their quality and determine optimal next steps before proceeding. Use your thinking to plan and iterate based on this new information, and then take the best next action.
* Before you finish work, ALWAYS verify your solution
* Do what has been asked; nothing more, nothing less.
* NEVER create files unless they're absolutely necessary for achieving your goal.
* ALWAYS prefer editing an existing file to creating a new one.
* NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
* Run tools in parallel when possible.
* ALWAYS use the test-runner-fixer agents to verify tests

## File & Directory Tasks (FAST)

### Listing

- **All files**: `fd . -t f` (fastest, recursive)  
- **All dirs**: `fd . -t d`  
- **Respect .gitignore**: `rg --files`  
- **Current dir only**: `ls -la`  

### Search Content

- `rg "pattern"` → search all files  
- Add filters:  
  - `-i` (ignore case)  
  - `-t py` (by type)  
  - `-g "*.md"` (by glob)  
  - `-n` (line numbers)  
  - `-A 3 -B 3 "error"` (context)  
- Batch: `rg "(foo|bar|baz)"`  

### Find by Name

- `fd "name"` → fastest filename search  
- `rg --files | rg "name"` → respects `.gitignore`  

### Rules

- 🚫 Do **NOT** use: `tree`, `find`, `grep`, `ls -R`, `cat | grep`  
- ✅ Use: `fd` (names), `rg` (content), `ls -la` (local)  

## PLANS
- Make the plan extemely concise.  Sacrifice grammar for the sake of brevity.
- At the end of each plan, always give me a list of unanswered questions to answer (if any).

## Commit & Review Policy
- NEVER commit code automatically unless explicitly told to do so by the user

## Code Quality
- Maintain 80%+ code coverage

## Testing & Verification
  - Run full test suite (e.g. `./gradlew check` if the project uses gradle) before declaring work complete, unless told not to by the user
  - ALWAYS ensure all new code has appropriate unit tests
  - ALWAYS create integration tests for significant features

## Progress Tracking
- ALWAYS Update implementation plans with progress tracker at each milestone
- Tag phases as COMPLETED with dates and summaries

## Pull Requests
- When requested to create a pull request, always create a DRAFT PR and format the description as follows:
  ```
  ## Motivation
  <A high level description of the goals and major changes for this PR>

  ## Propsed Changes
  <A more detailed set of changes included in the PR.  Don't be verbose.>
  ```

