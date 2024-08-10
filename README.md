# antinna

A new Flutter project.
# My Idea 
* cubit for basic app features ike themes and locales and codepush
* flutter_bloc or say bloc for advanced features

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Vs Code Freezed snippits <TAB>

```json
{
	"Part statement": {
		"prefix": "pts",
		"body": [
			"part '${TM_FILENAME_BASE}.g.dart';"
		],
		"description": "Creates a filled-in part statement"
	},
	"Part 'Freezed' statement": {
		"prefix": "ptf",
		"body": [
			"part '${TM_FILENAME_BASE}.freezed.dart';"
		],
		"description": "Creates a filled-in freezed part statement"
	},
	"Freezed Data Class": {
		"prefix": "fdataclass",
		"body": [
			"import 'package:freezed_annotation/freezed_annotation.dart';",
			"",
			"part '${TM_FILENAME_BASE}.freezed.dart';",
			"part '${TM_FILENAME_BASE}.g.dart';",
			"",
			"@freezed",
			"class ${1:DataClass} with _$${1:DataClass} {",
			"  const factory ${1:DataClass}({${2}}) = _${1:DataClass};",
			"",
			"  factory ${1:DataClass}.fromJson(Map<String, dynamic> json) => _$${1:DataClass}FromJson(json);",
			"}"
		],
		"description": "Freezed Data Class with JSON Serializable"
	},
	"Freezed Union": {
		"prefix": "funion",
		"body": [
			"import 'package:freezed_annotation/freezed_annotation.dart';",
			"",
			"part '${TM_FILENAME_BASE}.freezed.dart';",
			"",
			"@freezed",
			"class ${1:Union} with _$${1:Union} {",
			"  const factory ${1:Union}.${2}(${4}) = ${3};",
			"}"
		],
		"description": "Freezed Union"
	},
	"Freezed Union Case": {
		"prefix": "funioncase",
		"body": [
			"const factory ${1:Union}.${2}(${4}) = ${3};"
		],
		"description": "Freezed Union Case"
	}
}
```