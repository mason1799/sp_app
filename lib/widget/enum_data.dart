enum UserPermission {
  showEquiment,
  showContract,
  showmemberManager,
  memberManagerEdit,
  showserviceGroup,
  showcustomerSign,
  customerSignEdit,
  listAssignToMePermission,
  listAssignTicketPermission,
  listCancelTicketPermission,
  groupAssignToMePermission,
  groupAssignTicketPermission,
  groupCancelTicketPermission,
  detailAssignToMePermission,
  detailAssignTicketPermission,
  detailCancelTicketPermission,
  showCreateTroubleTicket,
  editEquipment,
  deleteEquipment,
  contractEdit,
  deleteContract,
}

enum RuleKey { checkInDeviation, checkOutDeviation, workDuration, enableMultiUser }

extension RuleKeyExtension on RuleKey {
  String get value => ['check_in_deviation', 'check_out_deviation', 'work_duration','enable_multi_user'][index];
}

enum FixOrderStatus { finish, pause, commit, checkIn, checkOut, accept, sign, cancelled }

enum FixOrderRole { mainRespond, assist, other }

enum TimeTagFormat { none, checkIn, checkOut, checkStuffs, remark }

extension TimeTagFormatExtension on TimeTagFormat {
  String get value => ['上传', '签到', '签退', '采集', '备注'][index];
}

enum CheckTicketItemStatus {
  qualified, // 合格
  unqualified, // 不合格
  fixed, // 已修复
  notApply, // 不适用
}

enum WordOrderFixButtonStatus {
  belong, // 所属维保组
  all, // 所有维保组
}
