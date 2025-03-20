import 'package:get/get.dart';
import 'package:kfps/kfps/kfps_page.dart';
import 'package:konesp/page/auth/check_code/check_code_binding.dart';
import 'package:konesp/page/auth/check_code/check_code_view.dart';
import 'package:konesp/page/auth/init_password/init_password_binding.dart';
import 'package:konesp/page/auth/init_password/init_password_view.dart';
import 'package:konesp/page/auth/login/login_binding.dart';
import 'package:konesp/page/auth/login/login_view.dart';
import 'package:konesp/page/auth/reset_password/reset_password_binding.dart';
import 'package:konesp/page/auth/reset_password/reset_password_view.dart';
import 'package:konesp/page/dashboard/contract/detail/contract_detail_binding.dart';
import 'package:konesp/page/dashboard/contract/detail/contract_detail_view.dart';
import 'package:konesp/page/dashboard/contract/edit/contract_edit_binding.dart';
import 'package:konesp/page/dashboard/contract/edit/contract_edit_view.dart';
import 'package:konesp/page/dashboard/contract/list/contract_list_binding.dart';
import 'package:konesp/page/dashboard/contract/list/contract_list_view.dart';
import 'package:konesp/page/dashboard/customer_signature/customer_signature_binding.dart';
import 'package:konesp/page/dashboard/customer_signature/customer_signature_view.dart';
import 'package:konesp/page/dashboard/department/department_binding.dart';
import 'package:konesp/page/dashboard/department/department_view.dart';
import 'package:konesp/page/dashboard/equipment/detail/equipment_detail_binding.dart';
import 'package:konesp/page/dashboard/equipment/detail/equipment_detail_view.dart';
import 'package:konesp/page/dashboard/equipment/edit/equipment_edit_binding.dart';
import 'package:konesp/page/dashboard/equipment/edit/equipment_edit_view.dart';
import 'package:konesp/page/dashboard/equipment/project_detail/project_detail_binding.dart';
import 'package:konesp/page/dashboard/equipment/project_detail/project_detail_view.dart';
import 'package:konesp/page/dashboard/equipment/project_list/project_list_binding.dart';
import 'package:konesp/page/dashboard/equipment/project_list/project_list_view.dart';
import 'package:konesp/page/dashboard/equipment/search_result/search_result_binding.dart';
import 'package:konesp/page/dashboard/equipment/search_result/search_result_view.dart';
import 'package:konesp/page/dashboard/member/detail/member_detail_binding.dart';
import 'package:konesp/page/dashboard/member/detail/member_detail_view.dart';
import 'package:konesp/page/dashboard/member/edit/member_edit_binding.dart';
import 'package:konesp/page/dashboard/member/edit/member_edit_view.dart';
import 'package:konesp/page/dashboard/member/list/member_list_binding.dart';
import 'package:konesp/page/dashboard/member/list/member_list_view.dart';
import 'package:konesp/page/dashboard/safeguard_signature/safeguard_signature_binding.dart';
import 'package:konesp/page/dashboard/safeguard_signature/safeguard_signature_view.dart';
import 'package:konesp/page/dashboard/service_group/detail/service_group_detail_binding.dart';
import 'package:konesp/page/dashboard/service_group/detail/service_group_detail_view.dart';
import 'package:konesp/page/dashboard/service_group/list/service_group_list_binding.dart';
import 'package:konesp/page/dashboard/service_group/list/service_group_list_view.dart';
import 'package:konesp/page/dashboard/service_group/parent/service_group_parent_binding.dart';
import 'package:konesp/page/dashboard/service_group/parent/service_group_parent_view.dart';
import 'package:konesp/page/main/main_view.dart';
import 'package:konesp/page/message/list/message_list_binding.dart';
import 'package:konesp/page/message/list/message_list_view.dart';
import 'package:konesp/page/mine/help/help_binding.dart';
import 'package:konesp/page/mine/help/help_view.dart';
import 'package:konesp/page/mine/help_center/help_center_binding.dart';
import 'package:konesp/page/mine/help_center/help_center_view.dart';
import 'package:konesp/page/mine/profile/profile_binding.dart';
import 'package:konesp/page/mine/profile/profile_view.dart';
import 'package:konesp/page/optional/web/web_binding.dart';
import 'package:konesp/page/optional/web/web_view.dart';
import 'package:konesp/page/order/assist_not_signs/assist_not_signs_binding.dart';
import 'package:konesp/page/order/assist_not_signs/assist_not_signs_view.dart';
import 'package:konesp/page/order/check_stuffs/check_stuffs_binding.dart';
import 'package:konesp/page/order/check_stuffs/check_stuffs_view.dart';
import 'package:konesp/page/order/comment/comment_binding.dart';
import 'package:konesp/page/order/comment/comment_view.dart';
import 'package:konesp/page/order/device_select/device_select_binding.dart';
import 'package:konesp/page/order/device_select/device_select_view.dart';
import 'package:konesp/page/order/fix_create/fix_create_binding.dart';
import 'package:konesp/page/order/fix_create/fix_create_view.dart';
import 'package:konesp/page/order/fix_detail/fix_detail_binding.dart';
import 'package:konesp/page/order/fix_detail/fix_detail_view.dart';
import 'package:konesp/page/order/fix_select_member/fix_select_member_binding.dart';
import 'package:konesp/page/order/fix_select_member/fix_select_member_view.dart';
import 'package:konesp/page/order/member_assist/member_assist_binding.dart';
import 'package:konesp/page/order/member_assist/member_assist_view.dart';
import 'package:konesp/page/order/over_time/over_time_binding.dart';
import 'package:konesp/page/order/over_time/over_time_view.dart';
import 'package:konesp/page/order/process/process_binding.dart';
import 'package:konesp/page/order/process/process_view.dart';
import 'package:konesp/page/order/regular_detail/regular_detail_binding.dart';
import 'package:konesp/page/order/regular_detail/regular_detail_view.dart';
import 'package:konesp/page/order/regular_select_member/regular_select_member_binding.dart';
import 'package:konesp/page/order/regular_select_member/regular_select_member_view.dart';
import 'package:konesp/page/order/remark/remark_binding.dart';
import 'package:konesp/page/order/remark/remark_view.dart';
import 'package:konesp/page/order/signature_board/signature_board_binding.dart';
import 'package:konesp/page/order/signature_board/signature_board_view.dart';
import 'package:konesp/page/task/group/detail/group_detail_binding.dart';
import 'package:konesp/page/task/group/detail/group_detail_view.dart';
import 'package:konesp/page/task/group/member_detail/group_member_detail_binding.dart';
import 'package:konesp/page/task/group/member_detail/group_member_detail_view.dart';
import 'package:konesp/page/task/group/project_detail/group_project_detail_binding.dart';
import 'package:konesp/page/task/group/project_detail/group_project_detail_view.dart';
import 'package:konesp/page/optional/search/search_binding.dart';
import 'package:konesp/page/optional/search/search_view.dart';
import 'package:konesp/page/task/search_result/search_task_result_binding.dart';
import 'package:konesp/page/task/search_result/search_task_result_view.dart';

class Routes {
  //应用根容器
  static const String main = '/';

  //登录
  static const String login = '/login';

  //手机验证码或邮箱验证码找回密码
  static const String checkCode = '/checkCode';

  //初次注册或忘记密码后设置密码
  static const String initPassword = '/initPassword';

  //故障报修
  static const String fixDetail = '/fixDetail';

  //检查项清单
  static const String checkStuffs = '/checkStuffs';

  //重置密码
  static const String resetPassword = '/resetPassword';

  //保养
  static const String regularDetail = '/regularDetail';

  //新建故障工单
  static const String fixCreate = '/fixCreate';

  //个人信息
  static const String profile = '/profile';

  //帮助中心
  static const String help = '/help';

  //工单进度
  static const String process = '/process';

  //辅助人员待签字列表
  static const String assistNotSigns = '/assistNotSigns';

  //签字板
  static const String signatureBoard = '/signatureBoard';

  //合同列表
  static const String contractList = '/contractList';

  //合同详情
  static const String contractDetail = '/contractDetail';

  //项目列表
  static const String projectList = '/projectList';

  //项目详情
  static const String projectDetail = '/projectDetail';

  //设备详情
  static const String equipmentDetail = '/equipmentDetail';

  //人员列表
  static const String memberList = '/memberList';

  //人员详情
  static const String memberDetail = '/memberDetail';

  //维保组列表
  static const String serviceGroupList = '/serviceGroupList';

  //维保组详情
  static const String serviceGroupDetail = '/serviceGroupDetail';

  //对应类型的消息列表
  static const String messageList = '/messageList';

  //安全员待签字列表
  static const String safeguardSignature = '/safeguardSignature';

  //客户待签字列表
  static const String customerSignature = '/customerSignature';

  //签字+审核意见
  static const String comment = '/comment';

  //超期管理
  static const String overTime = '/overTime';

  //备注
  static const String remark = '/remark';

  //网页
  static const String web = '/web';

  //设备编辑
  static const String equipmentEdit = '/equipmentEdit';

  //合同编辑
  static const String contractEdit = '/contractEdit';

  //部门
  static const String department = '/department';

  //编辑辅助人员
  static const String memberAssist = '/memberAssist';

  //故障选择成员
  static const String fixSelectMember = '/fixSelectMember';

  //保养选择成员
  static const String regularSelectMember = '/regularSelectMember';

  //人员编辑
  static const String memberEdit = '/memberEdit';

  //项目或设备搜索结果
  static const String searchEquipmentResult = '/searchEquipmentResult';

  //维保组详情
  static const String groupDetail = '/groupDetail';

  //维保组上一级（部门列表）
  static const String serviceGroupParent = '/serviceGroupParent';

  //维保组内人员详情（指定日期统计数据+工单列表）
  static const String groupMemberDetail = '/groupMemberDetail';

  //维保组内项目详情（指定日期统计数据+工单列表）
  static const String groupProjectDetail = '/groupProjectDetail';

  //设备空间
  static const String kfps = '/kfps';

  //选择设备
  static const String deviceSelect = '/deviceSelect';

  //(聚合搜索)工单搜索、设备项目搜索
  static const String search = '/search';

  //工单搜索结果
  static const String searchTaskResult = '/searchTaskResult';

  //1.10发版本前需要删除
  static const String helpCenter = '/helpCenter';

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: fixDetail, page: () => FixDetailPage(), binding: FixDetailBinding()),
    GetPage(name: checkStuffs, page: () => CheckStuffsPage(), binding: CheckStuffsBinding()),
    GetPage(name: checkCode, page: () => CheckCodePage(), binding: CheckCodeBinding()),
    GetPage(name: initPassword, page: () => InitPasswordPage(), binding: InitPasswordBinding()),
    GetPage(name: resetPassword, page: () => ResetPasswordPage(), binding: ResetPasswordBinding()),
    GetPage(name: regularDetail, page: () => RegularDetailPage(), binding: RegularDetailBinding()),
    GetPage(name: fixCreate, page: () => FixCreatePage(), binding: FixCreateBinding()),
    GetPage(name: profile, page: () => ProfilePage(), binding: ProfileBinding()),
    GetPage(name: help, page: () => HelpPage(), binding: HelpBinding()),
    GetPage(name: process, page: () => ProcessPage(), binding: ProcessBinding()),
    GetPage(name: assistNotSigns, page: () => AssistNotSignsPage(), binding: AssistNotSignsBinding()),
    GetPage(name: contractList, page: () => ContractListPage(), binding: ContractListBinding()),
    GetPage(name: contractDetail, page: () => ContractDetailPage(), binding: ContractDetailBinding()),
    GetPage(name: projectDetail, page: () => ProjectDetailPage(), binding: ProjectDetailBinding()),
    GetPage(name: equipmentDetail, page: () => EquipmentDetailPage(), binding: EquipmentDetailBinding()),
    GetPage(name: memberList, page: () => MemberListPage(), binding: MemberListBinding()),
    GetPage(name: memberDetail, page: () => MemberDetailPage(), binding: MemberDetailBinding()),
    GetPage(name: serviceGroupList, page: () => ServiceGroupListPage(), binding: ServiceGroupListBinding()),
    GetPage(name: serviceGroupDetail, page: () => ServiceGroupDetailPage(), binding: ServiceGroupDetailBinding()),
    GetPage(name: messageList, page: () => MessageListPage(), binding: MessageListBinding()),
    GetPage(name: safeguardSignature, page: () => SafeguardSignaturePage(), binding: SafeguardSignatureBinding()),
    GetPage(name: customerSignature, page: () => CustomerSignaturePage(), binding: CustomerSignatureBinding()),
    GetPage(name: comment, page: () => CommentPage(), binding: CommentBinding()),
    GetPage(name: signatureBoard, page: () => SignatureBoardPage(), binding: SignatureBoardBinding()),
    GetPage(name: overTime, page: () => OverTimePage(), binding: OverTimeBinding()),
    GetPage(name: remark, page: () => RemarkPage(), binding: RemarkBinding()),
    GetPage(name: web, page: () => WebPage(), binding: WebBinding()),
    GetPage(name: contractEdit, page: () => ContractEditPage(), binding: ContractEditBinding()),
    GetPage(name: equipmentEdit, page: () => EquipmentEditPage(), binding: EquipmentEditBinding()),
    GetPage(name: department, page: () => DepartmentPage(), binding: DepartmentBinding()),
    GetPage(name: memberAssist, page: () => MemberAssistPage(), binding: MemberAssistBinding()),
    GetPage(name: fixSelectMember, page: () => FixSelectMemberPage(), binding: FixSelectMemberBinding()),
    GetPage(name: regularSelectMember, page: () => RegularSelectMemberPage(), binding: RegularSelectMemberBinding()),
    GetPage(name: memberEdit, page: () => MemberEditPage(), binding: MemberEditBinding()),
    GetPage(name: projectList, page: () => ProjectListPage(), binding: ProjectListBinding()),
    GetPage(name: search, page: () => SearchPage(), binding: SearchBinding(), transition: Transition.noTransition),
    GetPage(name: searchEquipmentResult, page: () => SearchResultPage(), binding: SearchResultBinding()),
    GetPage(name: groupDetail, page: () => GroupDetailPage(), binding: GroupDetailBinding()),
    GetPage(name: serviceGroupParent, page: () => ServiceGroupParentPage(), binding: ServiceGroupParentBinding()),
    GetPage(name: groupMemberDetail, page: () => GroupMemberDetailPage(), binding: GroupMemberDetailBinding()),
    GetPage(name: groupProjectDetail, page: () => GroupProjectDetailPage(), binding: GroupProjectDetailBinding()),
    GetPage(name: kfps, page: () => KFPSPage()),
    GetPage(name: deviceSelect, page: () => DeviceSelectPage(), binding: DeviceSelectBinding()),
    GetPage(name: searchTaskResult, page: () => SearchTaskResultPage(), binding: SearchTaskResultBinding()),
    GetPage(name: helpCenter, page: () => HelpCenterPage(), binding: HelpCenterBinding()),
  ];
}
