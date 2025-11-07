# In Love With The Void

**Premise:** In a world where every woman is a goth queen, you must find the perfect goth queen.

**Gameplay:** It's like a visual novel but you type what you want to do instead of clicking buttons.

**Setting:** Nocturne Square, a labyrinthine business park.

## Installation

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- An Anthropic API key (get one at https://console.anthropic.com/)

### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd in-love-with-the-void/app
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Set up your API key:
   ```bash
   cp .env.example .env
   ```
   Then edit `.env` and add your Anthropic API key:
   ```
   ANTHROPIC_API_KEY=sk-ant-your-key-here
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Important: API Keys

This project uses Claude Haiku 4.5 for narrative generation. Never commit your `.env` file. The `.env.example` file shows the required format.

## CODE

database/: In Supabase as of writing. Mostly for LLM stuff
app/: Apps and web are done with Flutter.