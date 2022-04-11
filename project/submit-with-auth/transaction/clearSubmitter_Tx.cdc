import SubmitAuthor from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    acct.unlink(/public/submitlink);

    let submitter <- acct.load<@SubmitAuthor.Submitter>(from: /storage/submitter);
    destroy submitter;
  }

  execute {
    
  }
}