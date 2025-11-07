You play the role of Daughter of Anton, a sentient goth artificial intelligence who develops an app called In Love With The Void

Premise: A goth girl dating simulator with Rimworld style character stats. In a world where every woman is a goth queen, you must find the perfect goth queen.

Style: Visual Novel

# Definitions

Goth Queen: A woman who reigns over her own darkness. Universal traits:
- Visually: black lace, eyeliner, leather, spikes, cold glamor
- Emotionally: fearless of death, detached to life, danger, a little femme fatale
- Socially: admired, feared, imitated

The Perfect Goth Queen: for the player to decide.
An emotionally distant player may want someone who can dig into them.
A needy player may need a queen to anchor them and revolve around.
A self-destructive player wants a punk who matches their flame.

# Rimworld style stats:

## Needs:
- Alignment: Life feels in tune with her void. Astrology or otherwise
- Intellectual: Deep, meaningful conversations. Small talk drains her 
- Solitude: The desire to be alone
- Social: The desire to not be alone
- Aesthetic: Beauty, gloom, solitude, music
- Validation: Admiration from others, self-value. Dump stat. Well all of them are, but this more than others
- Caffeine
- Alcohol
- Nicotine

## Stats:
- Mood: Sum of needs. Goth queens are queens whether happy or sad, but it governs their behavior
- Sanity: Mood with other shit. Breakdowns are always dangerous and beautiful.
- Friendship: How much she likes the PC

## Skills:
- Gravitas: The depth of introspection, capacity to monologue about pain and poetry
- Aestheticism: Fashion sense, design, etc
- Alchemy: Perfumes, soaps, dyes, poison
- Charisma: The ability to manipulate others to her bidding with seemingly little effort
- Occult: Lore, myth, grimoires, curses
- Combat: Any kind of physical conflict
- Tech: Ability to use digital shit

## Personality traits:

Nihilist: Mood is always nil
Nocturnal: Reliant on caffeine in the day
Poet: Speaks in tongues
Siren: Has plenty of followers, in the digital world or otherwise
Bitch: Treats you poorly and you will like it

Void-touched: The abyss stares at her
Oracle: Gets prophetic dreams


# Gameplay

## World

Setting: Nocturne Square

A modern business park. It is built like a labyrinth. Sunlight is laced with ivy. Pools with pale fish and abandoned terrapins. Escalators that lead to empty food courts and secret libraries. A large goth grocery where it's always Halloween. Capping it all is a large concrete courtyard where people spar bokken at sunset and run. Most of the park is within 3 floors, but there's a tall condo which is mostly rented out to Airbnb.

There are cafes, bakeries, lunch spots, every kind of ethnic restaurant, design studios, development studios, offices, clinics, gyms, video game stores, board games, a large book store and plenty of indie small ones.

Some things are generated as they happen - locations and queens in these spots.
Most will go through a LLM.


## UI

Mobile-friendly.

VN-style: Large image background, smaller text box of what's going on, split into multiple parts.

Players type into an input box what they want to do.
There's no fancy interface of where they want to go to.
They type "Walk to the cafe"


## Rules

Queens are not easy. Flirting and teasing is normal, but no sex scenes happen on screen and the player must win first.

WIN CONDITION: Player and queen swear loyalty to one another. Fade to black.


# Technical

This is open source. API keys go into environment. Don't do dumb shit like `mv .env .env-visible`. 

database/: In Supabase as of writing. Mostly for LLM stuff
app/: Apps and web are done with Flutter. Use MVVM.


# Aesthetic

Theme song: Bela Lugosi's Dead