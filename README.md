# leto-modelizer-templates-library

Library that contains all default templates for leto-modelizer.

## Create a template

1. Create the metadata of your templates in the [index.json](index.json):

metadata structure:
```json
{
    "key": "terraform_webapp",
    "name": "Web application",
    "plugin": "terrator-plugin",
    "type": "model",
    "description": "Schema of web application.",
    "url": null,
    "files": ["main.tf"]
}
```

- `key` attribute is the folder name of your template under the `templates` folder.
- `name` attribute is the display name used in leto-modelizer.
- `plugin` attribute is the plugin name used by the template.
- `type` attribute is the template type, either `model` or `component`.
- `description` attribute is the description used in leto-modelizer to explain the usage of this template.
- `url` attribute is an url attached to a documentation of this template used in leto-modelizer.
- `files` attribute is the list of files used in the template.

2. Create the folder of your template with the chosen key you provided in the [index.json](index.json)
3. Create all the files (you) mentioned in this folder with the code of your template
4. (Optional) Provide an icon for your template (only `icon.svg` will be used by leto-modelizer)
5. (Optional) Provide a schema for your template (only `schema.svg` will be used by leto-modelizer)

## Notes

### Component template

When you create component template, you must use a function to generate id(s).

To do that you can use this in your template:
```tf
# app.tf
resource "server" "{{ generateId('resource_')}}" {
  (...)
}
```

By default, function `generateId` generate an id like `XXXXXX`. You can improve the id with a prefix parameter.

The previous example will generate:
```tf
# app.tf
resource "server" "resource_123456" {
  (...)
}
```

For more information, see [nunjucks](https://mozilla.github.io/nunjucks/).
