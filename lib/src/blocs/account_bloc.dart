import '../resources/repositories/account.repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/account.dart';

class AccountBloc {
  final _repository = AccountRepository.instance;
  final _allAccountsFetcher = PublishSubject<List<Account>>();

  Observable<List<Account>> get allAccounts => _allAccountsFetcher.stream;

  fetchAllAccounts() async {
    List<Account> accountModels = await _repository.fetchAll(0);
    _allAccountsFetcher.sink.add(accountModels);
  }

  dispose() {
    _allAccountsFetcher.close();
  }
}

final bloc = AccountBloc();
