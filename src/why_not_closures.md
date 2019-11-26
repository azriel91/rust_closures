# Why Not Closures

* Closures don't hold much contextual information (for humans).
* Similar to stringly-typed instead of strongly typed.

Closure:

```rust,ignore
// Trait:
// Fn(&Block, &Block) -> &Block;

// Implementation
let cipher_chain: Box<dyn Fn(&Block, &Block) -> &Block> =
    Box::new(|block_current, block_previous| -> Block { /* .. */ });
```

Trait:

```rust
/// Chain of encrypted block data.
pub trait CipherChain {
    /// The type of the block.
    type Block;

    /// Returns encrypted block data.
    ///
    /// # Parameters
    ///
    /// * `block_current`: Block to encrypt.
    /// * `block_previous`: Previous encrypted block.
    fn compute(block_current: &Self::Block, block_previous: &Self::Block) -> Self::Block;
}
```
