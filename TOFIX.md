# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `config/project.lua:3` - description says "Myworld written using gtk and python" (and `KEYWORDS` lists "python", line 7), but the app is C++/gtkmm (`main.cc`) and `README.md:3` says "This is a c++ myworld app". Fix the description/keywords to C++/gtkmm so the GitHub description and topics are accurate.
- `rsconstruct.toml:1` - `tera.templates/.github/dependabot.yml.tera` exists but there is no `[processor.tera]`, so the template is never rendered; the committed `.github/dependabot.yml:6-7` has already drifted (no blank line between entries, which the template emits). Add the tera processor and regenerate.
- `main.cc:1` - the "myworld" app is just the stock gtkmm "Hello World" button example; nothing touches the myworld database the project name promises. Either implement the myworld UI or describe the repo as a gtkmm hello-world placeholder.

## Low

- `main.cc:55` - `EXIT_SUCCESS` is used without `#include <cstdlib>`; it only compiles via transitive includes from gtkmm. Add the include.
- `main.cc:50` - `envp` is unused; use `int main(int argc, char** argv)`.
- `main.cc:51` - `Gtk::Main` is deprecated in gtkmm 3; port to `Gtk::Application::create(...)->run(window)`.
- `main.cc:10-11` - stale comment references `gtkmm-2.4` and `libgnomeui-2.0`, while the build (`scripts/build_gtk.py:11`) uses `gtkmm-3.0`. Drop or update the comment.
- `scripts/build_gtk.py:3` - docstring says it is "reproducing the Makefile", but there is no Makefile in the repo any more; reword.
- `firstinclude.h:4` - comment "THIS IS C FILE, NO C++ here" is wrong (it is included from C++ `main.cc`), and line 15 defines `__USE_GNU`, a glibc-internal macro that user code must not set (`_GNU_SOURCE` already implies it). Remove the `__USE_GNU` block and fix the comment.
- `pyproject.toml:10` - `pytest` is a dev dependency but the repo has no tests and no pytest processor in `rsconstruct.toml`; drop it.
- `doc/links.txt:2` - `https://developer.gnome.org/gtk3/stable/` is the retired GNOME developer site; the GTK 3 docs now live at `https://docs.gtk.org/gtk3/`.
