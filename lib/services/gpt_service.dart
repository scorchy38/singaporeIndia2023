import 'dart:convert';

import 'package:http/http.dart' as http;


class GPTService {


  Future<http.Response> fetchAnswer(String prompt) {
    var url = Uri.parse('https://api.openai.com/v1/engines/text-davinci-003/completions');
    var body = json.encode({"prompt": prompt, "max_tokens": 2000});

    return http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer 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"
      },
      body: body,
    );
  }
}

