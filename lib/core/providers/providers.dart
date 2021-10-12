import 'dart:convert';
import 'dart:io';

import 'package:critt_v2/core/services/services.dart';
import 'package:critt_v2/core/utils/dialog_utils.dart';
import 'package:critt_v2/core/utils/share.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/screens/screens.dart';
import 'package:critt_v2/core/model/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

part 'auth_provider.dart';
part 'transaksi_provider.dart';
part 'refund_provider.dart';
part 'article_provider.dart';
