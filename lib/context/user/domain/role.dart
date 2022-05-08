enum Role { admin, waiter, cashier }

Role stringToRole(String role) {
  switch (role) {
    case 'admin':
      return Role.admin;
    case 'waiter':
      return Role.waiter;
    case 'cashier':
      return Role.cashier;
    default:
      return Role.waiter;
  }
}
