
lambda<() -> bool> var1 = [ ] () -> void { };

lambda<() -> bool> var2 = [ ] () -> int { return 2; };

lambda<(int) -> int> var3 = [ ] () -> int { return 2; };

lambda<() -> void> var4 = [ ] () -> bool { return true; };

lambda<() -> void> var5 = [ ] (int x) -> void { };

lambda<(& int) -> void> var6 = [ ] (int x) -> void { };

lambda<(int) -> void> var7 = [ ] (& int y) -> void { };

