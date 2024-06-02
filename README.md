# κατηγορία

i argue that the default way to structure a rails application is bad, and
subsequently encourages bad design because components of a logical unit are
spread all over the place: in the `models` directory, the `services` (the
mechanism the rails community seems to have settled on for bundling executive
code together), sometimes `concerns`, etc.

look at [discourse][], my favorite rails project of all time, and it's almost
impossible to figure out the essence of the application. the entries in the
[`app/models`][dc_models] directory continues to grow with no end in sight. the
relationships between these models&mdash;who works with who and in what
capacity?&mdash;isn't immediately obvious.

categoria fixes this. it regroups data and executive code and separates them
along domain lines. it's similar in spirit to [phoenix's context][phxc]. the
point of departure is the following:

**a category/domain doesn't concern itself with the web part of the application.**

### directory structure of a domain

domains live under `app/lib` of the rails application. internally, it is
organized into three main categories, represented by directories and ruby module
namespaces:

- `internal`: to be described
- `command`: to be described
- `data`: to be described

[discourse]: https:/github.com/discourse/discourse
[dc_models]: https://github.com/discourse/discourse/tree/main/app/models
[phxc]: https://hexdocs.pm/phoenix/contexts.html
