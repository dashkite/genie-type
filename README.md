# Genie Type

*Generate stylesheets for responsive scalable typography*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Genie Type generates CSS stylesheets for responsive scalable typography based on a set of parameters.

## Configuration

Add the `type` preset to your `genie.yaml`:

```yaml
type:
  targets:
    browser:
      - namespace: copy
        levels:
          - smaller
          - small
          - default
          - large
          - larger
        harmonic: 0.25
        spacing: 0.6
        start: 4
        output: "www/shared/css/typography.css"
```

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

