## Testing instructions
- Find the CI plan in the .github/workflows folder.
- Run `uv run pytest` to run every check defined for that package.

## PR instructions
- Branch name must start at feat/<Title>
- Title format: [<project_name>] <Title>
- Always run `make format` and `make test` before committing.