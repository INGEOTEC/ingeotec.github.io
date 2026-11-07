# ingeotec.github.io
INGEOTEC

## Updating the site

The site is built with Jekyll (github-pages). Most content is plain YAML or
Markdown; no layout or stylesheet change is needed to add an entry.

- **Talk:** append an entry to the `talks` list of the right section in
  `_data/talks.yml` (or add a section). Keys: `title`, `link` (the published
  slides), `description`, `badge` and, optionally, `meta`. Page order is file
  order.
- **Course:** append an entry to `_data/courses.yml`, with the same keys
  (`badge` is the language of the course).
- **Software:** add a file to `_software/` with front matter `title`,
  `category` (one of the research lines under `software_category` in
  `_config.yml`), `github`, `description` and, optionally, `meta`; the body is
  the entry's own page.
- **Member:** edit the members card list under "Members" in `index.md`.

Build and check (Ruby 3.4 is required; do not run `bundle update`):

    PATH="/usr/local/opt/ruby@3.4/bin:$PATH" LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 bundle exec jekyll build
    bash scripts/check_site.sh                  # offline checks on _site/
    CHECK_LINKS=1 bash scripts/check_site.sh    # also checks every external link returns 200

If you add or remove talks, courses or software entries, update the expected
card counts in `scripts/check_site.sh`.
