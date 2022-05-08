import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/tables/cubit/table_cubit.dart';
import 'package:total_pos/context/account/domain/account.dart';

class AccountsGrid extends StatelessWidget {
  final List<Account> accounts;
  const AccountsGrid({Key? key, required this.accounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 6,
        children: accounts
            .map((account) => InkWell(
                onTap: () =>
                    context.read<TableCubit>().selectWaiter(account: account),
                child: Ink(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black12)),
                    child: Center(child: Text(account.user)))))
            .toList());
  }
}
