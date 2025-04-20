class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final int? creditsRemaining;
  final String? subscriptionTier;
  final String? token;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.creditsRemaining,
    this.subscriptionTier,
    this.token,
  });
}
