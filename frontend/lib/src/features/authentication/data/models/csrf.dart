class CsrfReqParams {
  final String? csrfToken;

  CsrfReqParams({
    this.csrfToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'csrfToken': csrfToken,
    };
  }
}
