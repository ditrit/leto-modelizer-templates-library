# leto-modelizer-templates-library

Library that contains all default templates for leto-modelizer.

## Create a template

1. Create the metadata of your templates in the [index.json](index.json):

metadata structure for model template:
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
metadata structure for component template:
```json
{
    "key": "terraform_webapp",
    "name": "Web application",
    "plugin": "terrator-plugin",
    "type": "component",
    "description": "Schema of web application.",
    "url": null,
    "files": ["main.tf"]
}
```
metadata structure for project template:
```json
{
    "key": "terraform_webapp",
    "name": "Web application",
    "plugins": ["terrator-plugin"],
    "type": "project",
    "description": "Schema of web application.",
    "url": null,
    "schemas": ["plugin1/model1/schemas.svg", "plugin1/model2/schemas.svg", "plugin2/model3/schemas.svg"],
    "files": ["plugin1/model1/main.js", "plugin1/model2/main.js", "plugin2/model3/app.js"]
}
```

- `key` attribute is the folder name of your template under the `templates` folder.
- `name` attribute is the display name used in leto-modelizer.
- `plugin` attribute is the plugin name used by the template. Only for `model` and `component` templates.
- `plugins` attribute is all plugin names used by the template. Only for `project` templates.
- `type` attribute is the template type, either `model`, `component` or `project`.
- `description` attribute is the description used in leto-modelizer to explain the usage of this template.
- `url` attribute is an url attached to a documentation of this template used in leto-modelizer.
- `schemas` attribute is the list of schemas of this project. Same as `files`, only for `project` template.
- `files` attribute is the list of files used in the template.

2. Create the folder of your template with the chosen key you provided in the [index.json](index.json)
3. Create all the files (you) mentioned in this folder with the code of your template
4. (Optional) Provide an icon for your template (only `icon.svg` will be used by leto-modelizer)
5. (Optional) Provide a schema for your template (only `schema.svg` will be used by leto-modelizer)

## Notes

### Component position

If you want to specify the position of the component(s) of your template, you need to do it in the file 'leto-modelizer.config.json'.
The content will specify the name of the plugin(s), the component(s) associated and their position attributes.

```json
{
  "terrator-plugin": {
    "eu-west-3a": {
      "x": 154.099609375,
      "y": -6.573709487915039,
      "width": 110,
      "height": 80,
      "needsResizing": false,
      "needsPositioning": false
    }
  }
}
```

The content of this file will be added to the project config file like this:

```json
{
  "modelName": {
    "terrator-plugin": {
      "eu-west-3a": {
        "x": 154.099609375,
        "y": -6.573709487915039,
        "width": 110,
        "height": 80,
        "needsResizing": false,
        "needsPositioning": false
      }
    }
  }
}
```

Don't forget to add 'leto-modelizer.config.json' in the attribute 'files' of you template in 'index.json'.

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

### Project template

When you create project template, you need to specify all `plugins` the template will use. You have to add `models` with the list of models for your project. If you want to use existing models, you need to copy them in your project template folder.

Example of metadata structure for project template with 2 plugins and 3 models:
```json
{
    "key": "example_project",
    "name": "Example project",
    "plugins": ["terrator-plugin", "githubator-plugin"],
    "type": "project",
    "description": "Example project with multiple plugins and models.",
    "url": null,
    "schemas": ["plugin1/model1/schemas.svg", "plugin1/model2/schemas.svg", "plugin2/model3/schemas.svg"],
    "files": ["plugin1/model1/main.js", "plugin1/model2/main.js", "plugin2/model3/app.js"]
}
```
- Provide an icon for your template at the root folder (only `icon.svg` will be used by leto-modelizer)
- Provide a schema for each of your model (only `schema.svg` will be used by leto-modelizer)
