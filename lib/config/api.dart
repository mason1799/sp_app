class Api {
  ///登录
  static const String login = '/auth/login';

  ///获取滑动验证码
  static const String getCaptcha = '/auth/captcha/get';

  ///校验滑动验证码
  static const String checkCaptcha = '/auth/captcha/check';

  ///发送验证码
  static const String sendValidateCode = '/auth/sendValidateCode';

  ///检查验证码
  static const String checkValidateCode = '/auth/checkValidateCode';

  ///忘记密码
  static const String forgetPassword = '/auth/forgetPassword';

  ///重置密码
  static const String resetPassword = '/auth/resetPassword';

  ///检查更新
  static const String checkUpdate = '/ums/appManagement/quyerVersion';

  ///阿里云oss token
  static const String aliyunOssToken = '/ums/sts';

  ///帮助中心视频列表
  static const String helpCenter = '/ums/getHelpVideoList';

  ///app权限列表
  static const String queryPermissions = '/ums/permission/user/app/getPermCode';

  ///用户信息
  static const String queryUserInfo = '/ums/permission/user/userinfo';

  ///修改资料
  static const String editUserInfo = '/ums/permission/user/sign';

  ///主响应人列表
  static const String mainResponseList = '/ums/maintenanceGroup/listAndMembers';

  ///编辑成员
  static const String editMember = '/ums/permission/user/addUser';

  ///成员详情
  static const String memberDetail = '/ums/permission/user/%s';

  ///校验成员
  static const String validateMember = '/ums/permission/user/validateSave';

  ///绑定极光id
  static const String bindRegId = '/ums/nofication/app/bindRegId';

  ///消息未读数量
  static const String unreadCount = '/ums/nofication/app/unread';

  ///未读消息列表
  static const String messageListOfType = '/ums/nofication/app/unreadList';

  ///全部已读
  static const String readAll = '/ums/nofication/app/read';

  ///查维保组
  static const String maintenanceGroups = '/ums/maintenanceGroup/queryMaintenanceGroups';

  ///成员列表
  static const String memberList = '/ums/department/getUserListByPermissionDept/app';

  ///分区部门
  static const String branchDepartment = '/ums/department/getDeptListByUserPermission';

  ///维保组列表
  static const String serviceGroups = '/ums/maintenanceGroup/queryGroupInfos';

  ///团队内成员的部门信息
  static const String teamMemberDepartments = '/ums/department/queryCurrenUserDepartments';

  ///工单配置规则
  static const String getOrderRules = '/walkRepair/workOrder/getWorkOrderRules';

  ///工作台
  static const String dashboard = '/walkRepair/app/dashboard/view';

  ///客户未签字数量
  static const String customerUnsignCount = '/walkRepair/orders/countUnSignNumber';

  ///保养工单详情
  static const String regularOrderDetail = '/walkRepair/orders/queryOrderDetail/%s';

  ///查询保养工单进度
  static const String regularOrderProcesses = '/walkRepair/orders/queryOrderStep/%s';

  ///重置保养工单
  static const String resetRegularOrder = '/walkRepair/orders/resetOrder/%s';

  ///判断保养工单是否超期
  static const String checkRegularOrderOverTime = '/walkRepair/order/isExistOrderOverTime';

  ///插入保养工单编排
  static const String insertRegularOrderAdjustment = '/walkRepair/order/saveOrderAdjustment';

  ///保养工单批量提交签字
  static const String submitRegularOrderMultipleSign = '/walkRepair/orders/signOrder';

  ///保养工单单个提交签字
  static const String submitRegularOrderOneSign = '/walkRepair/orders/signature';

  ///提交保养工单
  static const String submitRegularOrder = '/walkRepair/orders/submitOrder';

  ///取消保养工单
  static const String cancelRegularOrder = '/walkRepair/orders/cancel';

  ///调整保养工单签退时间
  static const String adjustRegularOrderCheckOut = '/walkRepair/orders/adjustSignOutTime';

  ///调整保养工单签到时间
  static const String adjustRegularOrderCheckIn = '/walkRepair/orders/adjustSignInTime';

  ///保存保养工单备注图片
  static const String saveRegularOrderRemarks = '/walkRepair/orders/remark/save';

  ///保存辅助人员
  static const String saveRegularOrderAssists = '/walkRepair/orders/helper/save';

  ///提交检查项
  static const String submitCheckStuffs = '/walkRepair/orderItem/insertList';

  ///检查项详情
  static const String checkStuffsDetail = '/walkRepair/orderItem/queryCheckContent/%s';

  ///转派保养工单
  static const String transferRegularOrder = '/walkRepair/orders/transferOrder';

  ///保养工单未签字列表
  static const String regularOrderUnsignList = '/walkRepair/orders/queryUnSignOrder';

  ///保养工单签到
  static const String checkInRegularOrder = '/walkRepair/orders/orderSignIn';

  ///保养工单签退
  static const String checkOutRegularOrder = '/walkRepair/orders/orderSignOut';

  ///故障工单详情
  static const String fixOrderDetail = '/walkRepair/faultRepairOrder/queryDetail/%s';

  ///创建故障工单
  static const String createFixOrder = '/walkRepair/faultRepairOrder/createOrder';

  ///故障工单批量提交签字
  static const String submitFixOrderMultipleSign = '/walkRepair/orders/signRepair';

  ///故障工单单个提交签字
  static const String submitFixOrderOneSign = '/walkRepair/faultRepairOrder/signature';

  ///接受故障工单
  static const String acceptFixOrder = '/walkRepair/faultRepairOrder/acceptOrder';

  ///故障工单签到
  static const String checkInFixOrder = '/walkRepair/faultRepairOrder/orderSignIn';

  ///故障工单签退
  static const String checkOutFixOrder = '/walkRepair/faultRepairOrder/orderSignOut';

  ///提交故障工单
  static const String submitFixOrder = '/walkRepair/faultRepairOrder/submitOrder';

  ///故障工单进度列表
  static const String fixOrderProcesses = '/walkRepair/faultRepairOrder/queryRepairFlow/%s';

  ///暂停故障工单
  static const String pauseFixOrder = '/walkRepair/faultRepairOrder/pauseOrder';

  ///转派故障工单
  static const String transferFixOrder = '/walkRepair/faultRepairOrder/transferOrder';

  ///重置故障工单
  static const String resetFixOrder = '/walkRepair/faultRepairOrder/resetOrder';

  ///修改故障工单签到时间
  static const String adjustFixOrderCheckIn = '/walkRepair/faultRepairOrder/adjustSignInTime';

  ///修改故障工单签退时间
  static const String adjustFixOrderCheckOut = '/walkRepair/faultRepairOrder/adjustSignOutTime';

  ///取消故障工单
  static const String cancelFixOrder = '/walkRepair/faultRepairOrder/cancel';

  ///恢复故障工单
  static const String resumeFixOrder = '/walkRepair/faultRepairOrder/restoreOrder';

  ///保存故障工单辅助人员
  static const String saveFixOrderAssists = '/walkRepair/faultRepairOrder/helper/save';

  ///保存故障工单备注图片
  static const String saveFixOrderRemarks = '/walkRepair/faultRepairOrder/remark/save';

  ///故障工单未签字列表
  static const String fixOrdersUnsignList = '/walkRepair/orders/queryUnSignRepair';

  ///安全员未签字列表
  static const String safeguardUnsignList = '/walkRepair/orders/querySafetyOfficerUnSignOrder';

  ///安全员提交签字
  static const String submitSafeguardSign = '/walkRepair/orders/safetyOfficerSignOrder';

  ///工单列表
  static const String queryTaskList = '/walkRepair/orders/queryTastOrder';

  ///日历（红点/蓝点）
  static const String calendarMarks = '/walkRepair/orders/queryTast';

  ///所属维保组
  static const String belongGroupOrders = '/walkRepair/orders/queryGroupOrders';

  ///获取所有维保组
  static const String queryAllGroups = '/walkRepair/orders/queryAllGroups';

  ///获取该成员的所有工单
  static const String queryMemberAllOrders = '/walkRepair/orders/queryOrderList';

  //故障工单选取设备
  static const String deviceListByProject = '/maintain/equipment/listGroupByProject';

  ///编辑合同
  static const String submitContract = '/maintain/app/updateContractInfo';

  ///删除合同
  static const String deleteContract = '/maintain/app/delContractInfo/%s';

  ///合同列表
  static const String contractList = '/maintain/app/contract/getContractInfoList';

  ///合同详情
  static const String contractDetail = '/maintain/app/contract/%s';

  ///编辑设备
  static const String submitDevice = '/maintain/app/updateEquipmentInfo';

  ///删除设备
  static const String deleteEquipment = '/maintain/app/delEquipmentInfo/%s';

  ///项目列表
  static const String projectList = '/maintain/project/search';

  ///设备列表所属的项目列表
  static const String searchProjectList = '/maintain/app/equipment/searchProjectList';

  ///设备里的综合搜索
  static const String searchProjectAndEquipment = '/maintain/app/equipment/search';

  ///项目设备列表
  static const String equipmentList = '/maintain/app/equipment/searchProjectEquipmentList';

  ///设备详情
  static const String equipmentDetail = '/maintain/app/equipment/%s';
}
