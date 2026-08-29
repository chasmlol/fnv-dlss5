# Security

ReShade add-ons, wrappers, and graphics injectors are native libraries with
the same user-level access as the game process.

- Download runtime dependencies only from their original publishers.
- Verify signatures and cryptographic hashes where publishers provide them.
- Treat unsigned `.addon64`, `.addon32`, and `.dll` files as executable code.
- Do not load binaries without verifiable publisher and release provenance.
- Release binaries are built from the source patches published here.

For a security issue in original repository code, open a private GitHub
security advisory rather than a public issue.
