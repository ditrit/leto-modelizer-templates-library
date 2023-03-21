# leto-modelizer-templates-library

Library that contains all default templates for leto-modelizer.

## Type of template

We have 3 types of template: `project`, `model` and `component`.

### Template of project

Template of project is used to create a complete project structure with default wanted files.

### Template of model

Template of model is used to create a complete schema related to one plugin.

### Template of component(s)

Template of component is used to be added in an existing schema (empty or not) of one plugin.

## Create a template

### Index of library

A template library must have an [index.json](index.json) at the root folder of the library.

It will be used by leto-modelizer to retrieve all templates of your library.

The index file will have this structure:

```json
{
  "name": "Leto-modelizer-templates-library",
  "version": "0.1.0",
  "description": "Library that contains all default templates for leto-modelizer.",
  "url": "",
  "authors": [
    "Vincent Moittie <moittie.vincent@gmail.com>"
  ],
  "tags": [],
  "icon": "",
  "templates": []
}
```

Attributes explanation:
* `name`: String, **mandatory**.

  This attribute is the display name used in leto-modelizer.

* `version`: String, **mandatory**.

  This attribute is the version number of your library.

* `description`: String, **mandatory**.

  This attribute is the description used in leto-modelizer to explain the usage of this library.

* `url`: String, optional.

  This attribute is an url attached to the documentation of this template used in leto-modelizer.

* `authors`: String[], **mandatory**.

  This attribute is a list of maintainer of the library.

* `tags`: String[], optional.

  This attribute is the list of tags this library used in leto-modelizer.

* `icon`: String, **mandatory**.

  This attribute is the icon of this library used in leto-modelizer.

* `templates`: String[], **mandatory**.

  This attribute is a list of all template definitions to be used in leto-modelizer.

Next topic will describe the `templates` structure.

### Default metadata template structure

Default metadata structure for any types of template:
```json
{
  "type": "component|model|project",
  "name": "Template 1",
  "description": "Description of template 1.",
  "url": null,
  "icon": null,
  "tags": [],
  "schemas": [],
  "files": []
}
```

Attributes explanation:
* `type`: String, **mandatory**.

  This attribute is the template type, either `model`, `component` or `project`.

* `name`: String, **mandatory**.

  This attribute is the display name used in leto-modelizer.

* `description`: String, optional.
 
  This attribute is the description used in leto-modelizer to explain the usage of this template.

* `url`: String, optional.

  This attribute is an url attached to the documentation of this template used in leto-modelizer.

* `icon`: String, **mandatory**.

  This attribute is the icon of this template used in leto-modelizer.

* `tags`: String[], optional.

  This attribute is the list of tags that can be used in leto-modelizer.

* `schemas`: String[], **mandatory**.

  This attribute is the list of path related to an image in the library, to display models inside the carrousel in leto-modelizer.

  Each element of this array is linked to an existing file in the library. It must be a valid path from the root of the library folder.

* `files`: String[], **mandatory**.

  This attribute is the list of files/folders in the library. This list will be imported in the user project on template creation.

  Each element of this array is linked to a file/folder in the library. It must be a valid path from the root of the library folder.

  If you specify a folder, all the content of the specified folder will be imported.

### Specific metadata template structure for component template:

Metadata structure for component template:

```json
{
  // Default metadata attributes:
  (...),
  // Specific attribute:
  "plugin": "githubator-plugin",
}
```

Attributes explanation:
* `plugin`: String, **mandatory**.

  This attribute is the plugin name used by the template.

### Specific metadata template structure for model template:

Metadata structure for model template:

```json
{
  // Default metadata attributes:
  (...),
  // Specific attributes:
  "plugin": "githubator-plugin",
  "targetFolder": ".github/workflows",
  "exclude": []
}
```

Attributes explanation:
* `plugin`: String, **mandatory**.

  This attribute is the plugin name used by the template.

* `targetFolder`: String, **mandatory**.

  This attribute indicates the location of the files in the user project. If the folder doesn't exist, we create it.

  If you specify a folder in the `files` list, we take all the contents of the specified folder and put them in the `targetFolder`.

* `exclude`: String[], optional.

  This attribute is a list of RegExp to exclude some files from moving into the `targetFolder`.

**Examples of metadata**:

* For `githubator-plugin`:

```json
{
  "type": "model",
  "plugin": "githubator-plugin",
  "name": "Default JS front-end workflow",
  "description": "Default JS front-end workflow",
  "tags": ["CI", "GithubAction", "JS", "front-end"],
  "icons": "/templates/DefaultWorkflowJS/icon.svg",
  "schemas": ["/templates/DefaultWorkflowJS/schemas.svg"],
  "files": ["/templates/DefaultWorkflowJS/CI-JS.yml"],
  "targetFolder": ".github/workflows",
  "exclude": []
}
```

In this example, the file `/templates/DefaultWorkflowJS/CI-JS.yml` will be imported into `.github/workflows` in user folder.

So you would have `.github/workflows/CI-JS.yml`.

* For `terrator-plugin`:

```json
{
  "type": "model",
  "plugin": "terrator-plugin",
  "name": "Default aws infra",
  "description": "Default infra for aws provider",
  "tags": ["CI", "Terraform", "AWS"],
  "icons": "/templates/TerraformInfra/icon.svg",
  "schemas": ["/templates/TerraformInfra/schema.svg"],
  "files": ["/templates/TerraformInfra"],
  "targetFolder": "terraform/infra",
  "exclude": ["^*\\.svg$"]
}
```

`/templates/TerraformInfra` contains: `icon.svg`, `schema.svg`, `main.tf` and `provider/provider.tf`.

In this example, the file `/templates/TerraformInfra/main.tf` and `/templates/TerraformInfra/provider/provider.tf` will be imported into `terraform/infra` in user folder.

So you would have `terraform/infra/main.tf` and `terraform/infra/provider/provider.tf`.

## Notes

### Component template

When you create component template, you may want to have id for your component.
In this case, you can use a function to generate id(s).

To do that, you can use this in your template:
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
