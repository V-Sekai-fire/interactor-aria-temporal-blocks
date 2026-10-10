# interactor-aria-temporal-blocks

A temporal blocks-world planning domain in Elixir, with durative actions, for testing the hybrid planner.

## What it is for

It extends the classic blocks world with actions that take time and a gripper that is a shared resource, so the hybrid planner's temporal scheduling is tested against a well-known domain.

## Build and test

```sh
mix deps.get
mix test
```

## Licence

MIT. See [LICENSE](LICENSE).
