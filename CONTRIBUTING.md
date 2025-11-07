# Contributing to In Love With The Void

Welcome, fellow void-dweller. This project is open source, and contributions are welcome.

## Code of Conduct

Be respectful. We're all here to build something dark and beautiful. Don't be a dick.

## Getting Started

1. Fork the repository
2. Follow the [installation instructions](README.md#installation)
3. Create a branch for your changes:
   ```bash
   git checkout -b your-branch-name
   ```

## Development Guidelines

### Architecture

This project uses **MVVM** (Model-View-ViewModel) architecture with Flutter:

- **Models** (`app/lib/models/`): Data structures (GothQueen, Location, Stats, etc.)
- **Views** (`app/lib/views/`): UI components (Flutter widgets)
- **ViewModels** (`app/lib/viewmodels/`): Business logic, state management
- **Repositories** (`app/lib/repositories/`): Data access layer
- **Services** (`app/lib/services/`): External services (API calls, etc.)

### Code Style

- Follow Dart conventions
- Run `flutter analyze` before committing
- Keep it readable - this is a goth dating sim, not obfuscated malware

### API Keys

**NEVER commit API keys or the `.env` file.**

The `.env` file is in `.gitignore` for a reason. If you accidentally commit it, revoke the key immediately and rotate it.

## What to Contribute

### Priority Areas

- **LLM Integration**: Improve the Claude prompts, add context management
- **Character Generation**: Dynamic goth queen generation
- **Location System**: Procedural generation of Nocturne Square locations
- **Stats System**: Make the stats actually useful
- **UI/UX**: Fonts, images, etc. Keep it mobile-friendly.

## Submitting Changes

1. Make your changes in your branch
2. Test thoroughly
3. Run `flutter analyze` and fix any issues
4. Commit with clear, descriptive messages:
   ```bash
   git commit -m "Add: New trait system"
   ```
5. Push to your fork:
   ```bash
   git push origin your-branch-name
   ```
6. Open a Pull Request

### Pull Request Guidelines

- Describe what you changed and why
- Reference any related issues
- Include screenshots for UI changes
- Make sure tests pass
- Keep PRs focused - one feature/fix per PR

## Project Philosophy

### Make it fun, make it work, make it fast/cheap/pretty

In that order. Don't write tests for things that aren't fun. Don't refactor things that don't work or don't have tests. 

It's not even that fun yet. Work on smaller gameplay loops (next 5 min, 10 min) before larger ones (end game, new systems).

### Minimize large files

If it's over 1 MB, ask whether it adds enough to the game? Can it be smaller? Compressed? Can you put it on S3/CDN and load it? Git is designed for plaintext.

Similarly think whether that new dependency is needed. If it takes twice as long to write a code than it would to integrate it, just write the code.

### Content generation

Hardcoded is easiest to write and debug, but it gets repetitive. 

Procedural generation is a way to keep things interesting. Beware the oatmeal effect. You can generate unique kernels of oat, but once they're combined together they become a blob of oatmeal.

AI generation is
1) Highly unreliable. What works today will be different tomorrow and too many of these are difficult to test and debug.
2) Naive. They're easily fooled and throw balance to the wind. Which can be fun, but only if you want it.
3) Expensive.

Use AI generation sparingly to increase interactivity and ask whether it can be procgenned.

## Questions?

Open an issue for:
- Bug reports
- Feature requests
- Questions about the codebase
- Discussions about game design

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
