# Genie Type

*Generate stylesheets for responsive scalable typography*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Genie Type generates CSS stylesheets for responsive scalable typography based on a set of parameters.

## Usage

Add a YAML file to your root directory that contains your type specifiers:

```yaml
- namespace: heading
  harmonic: 0.33
  spacing: 0.8
  start: 3
```

Target the files from you `genie.yaml`, using the `type` key:

```yaml
type:
  targets:
    browser:
      - preset: css
        root: "www"
        glob: "shared/css/**/*.yaml"
```

(If you’re also targeting YAML with a preset like Genie YAML, be sure to exclude your Genie Type files.)

Genie Type will generate stylesheets corresponding to the YAML files that you can `link` to from your Web page.

## Generated CSS

The preset generates CSS variables in `:root` and corresponding classes:

```css
:root {
  --default-copy-line-height: ...;
  --default-copy-font-size: ...;
}

.default.copy {
  line-height: var(--default-copy-line-height);
  font-size: var(--default-copy-font-size);
}
```

You will typically want to augment this with custom properties for the font-family, like so:

```stylus
--copy-font-family "Roboto Serif", serif
```

You can set these in a separate file if you want, allowing you to have consistent scaling across different typographical themes.

## Defaults

The specifier defaults are:

```yaml
levels:
  - smallest
  - smaller
  - small
  - default
  - large
  - larger
  - largest
container:
  minimum: 20
  maximum: 70
  units: "ch"
harmonic: 1/3
spacing: 3/5
start: 6
scale:
  factor: 0.25
  units: "rem"
responsiveness: 1
```

Any of these may be overriden. You must always provide a namespace however.
