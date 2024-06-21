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
that is because the web concerns tend to be cross-cutting (across domains). in a
controller action, it's possible to invoke several commands from different
domains in service of the request. the returned response might also be a
combination of data from different domains. in order to allow this freedom, all
app components that directly handle web requests can remain in their
conventional locations.

what to call controllers? typically they have matched a given model. you have a
`Document` model, here's the `DocumentsController`. now that the document model
is subsumed under a domain of different name, the controller should be allowed
to float freely. it could be an interface to a domain, or to several domains at
the same time. an appropriate name should be chosen.

### directory structure of a domain

domains live under `app/lib` of the rails application. internally, it is
organized into three main categories, represented by directories and ruby module
namespaces. all domains are sub-namespaced under the application's main
namespace. an initializer is added to override zeitwerk's default behavior of
using `Object` as the root namespace for classes loaded from `app/lib`.

#### `internal`
#### `command`
#### `data`

## Test

the same structure is repeated under the `test` directory, under universal
`Test` namespace. just so constant loading, in non-test local and remote (prod)
environments don't load unnecessary code. the `Test` namespace should only be
loaded in a test environment.

[discourse]: https:/github.com/discourse/discourse
[dc_models]: https://github.com/discourse/discourse/tree/main/app/models
[phxc]: https://hexdocs.pm/phoenix/contexts.html
