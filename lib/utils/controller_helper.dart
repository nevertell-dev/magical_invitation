extension ControllerEndModifier on double? {
  double? at(double mod, [double? begin]) {
    if (this == null) return this;

    return ((this! - (begin ?? 0)) * mod) + (begin ?? 0);
  }
}
