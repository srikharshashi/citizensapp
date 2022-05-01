import 'package:citizensapp/constants.dart';
import 'package:citizensapp/models/file.dart';

class Case {
  String ID;
  String description;
  double lat;
  double long;
  String time;
  String offenders;
  String victims;
  String status;
  List<CustomFile> file;

  Case(
      {required this.ID,
      required this.description,
      required this.lat,
      required this.long,
      required this.offenders,
      required this.victims,
      required this.status,
      required this.time,
      required this.file});

  factory Case.fromJSON(Map<String, dynamic> parsedjson) {
    parsedjson = parsedjson["case_info"];
    return Case(
        ID: parsedjson["_id"],
        description: parsedjson["desc"],
        lat: parsedjson["location"][0],
        long: parsedjson["location"][1],
        offenders: parsedjson["offenders"],
        victims: parsedjson["victims"],
        status: parsedjson["Status"],
        time: parsedjson["time"],
        file: List<CustomFile>.from(parsedjson["crime_files"].map((e) {
          return CustomFile(ID: e[0], fileType: getFileType(e[1]));
        })));
  }
}

getFileType(String type) {
  switch (type) {
    case "image":
      return CustomFileType.image;
    case "audio":
      return CustomFileType.audio;
    case "video":
      return CustomFileType.video;
    default:
      return CustomFileType.newfile;
  }
}
