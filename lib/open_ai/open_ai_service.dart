import 'package:dart_openai/dart_openai.dart';

class OpenAiService {
// the system message that will be sent to the request.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "return any message you are given as JSON.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  // the user message that will be sent to the request.
  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "Hello, I am a chatbot created by OpenAI. How are you today?",
      ),

      //! image url contents are allowed only for models with image support such gpt-4.
      OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
        "https://placehold.co/600x400",
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

// // the actual request.
// OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
//   model: "gpt-3.5-turbo-1106",
//   responseFormat: {"type": "json_object"},
//   seed: 6,
//   messages: requestMessages,
//   temperature: 0.2,
//   maxTokens: 500,
// );

  Future<void> ask() async {
    OpenAIChatCompletionModel? res = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Hello",
            ),
          ],
        ),
      ],
    );

    print('OPEN AI : ${res.choices.first.message}');
  }
}
