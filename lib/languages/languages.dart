import 'package:flutter/cupertino.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get tasksForTheDay;
  String get languageConstant;
  String get referral;
  String get login;
  String get streak;
  String get place;
  String get noTaskForToday;

  String get labelSelectLanguage;
  String get aboutFrutx;
  String get newAccount;
  String get getOTP;
  String get enterPhone;
  String get completeProfileText;
  String get profileDetails;
  String get uploadImage;

  String get enterName;

  String get enterEmail;

  String get enterFatherName;

  String get enterGender;

  String get enterDOB;

  String get addressDetails;

  String get enterAddressLine1;

  String get enterAddressLine2;

  String get enterLandmark;

  String get enterDistrict;

  String get enterCity;

  String get enterState;

  String get educationDetails;

  String get enterDegree;

  String get enterFieldOfStudy;

  String get enterFarmingExperience;

  String get landAcreage;

  String get enterTotalLandInAcres;

  String get enterLocationOfLand;

  String get assetDetails;

  String get dripSyatem;

  String get ownATractor;

  String get soilDetails;

  String get selectTypeOfSoil;

  String get otherDetails;

  String get enterNameOfExecutive;

  String get enterOtherFarmDetails;

  String get termsAndConditions;

  String get currentDay;

  String get viewProfile;

  String get confirmSignOut;

  String get executive;

  String get contact;

  String get raiseAnIssue;

  String get raiseAndViewIssues;

  String get orderSeedlings;

  String get createAndViewOrders;

  String get slotBooking;

  String get createAndViewSlots;

  String get updateKhasraLocation;

  String get submissionDate;

  String get viewFullTaskList;

  String get date;

  String get quantity;

  String get tonnes;

  String get slots;

  String get bookSlot;

  String get previousSlots;

  String get bookDeliverySlots;

  String get orderingFor;

  String get availableSlots;

  String get deliveryQuantity;

  String get enterTheQuantityInTonnes;

  String get enterOtherDetailsIfAny;

  String get noSlotsAvailable;

  String get previouslyBookedSlots;

  String get status;

  String get noSlotsBookedYet;

  String get taskList;

  String get tasks;

  String get fertilizers;

  String get pesticides;

  String get showFullList;

  String get showTodaysTasks;

  String get todaysTasks;

  String get taskStatus;

  String get taskDetails;

  String get subTasks;

  String get day;

  String get submittedLate;

  String get pending;

  String get completed;

  String get markAsCompleted;

  String get uploadRelatedVideosIfAny;

  String get uploadRelatedPhotosIfAny;

  String get submitNow;

  String get viewDetails;

  String get issues;

  String get newI;

  String get pastIssues;

  String get raiseANewIssue;

  String get category;

  String get selectIssueCategory;

  String get subCategory;

  String get selectSubcategory;

  String get raiseNewIssue;

  String get issueCategory;

  String get raisedOn;

  String get issueDetail;

  String get orders;

  String get pastOrders;

  String get createNewOrder;

  String get crop;

  String get selectCrop;

  String get khasraNumber;

  String get selectKhasraNumber;

  String get farmingMethod;

  String get selectFarmingMethod;

  String get village;

  String get enterVillageName;

  String get area;

  String get enterAreaInAcres;

  String get numberOfPlants;

  String get totalAmount;

  String get advanceAmount;

  String get balanceAmount;

  String get tentativeSowingDate;

  String get bankDetails;

  String get accountHoldersName;

  String get enterAccountHoldersName;

  String get accountNumber;

  String get enterAccountNumber;

  String get ifscCode;

  String get enterIfscCode;

  String get createOrder;

  String get orderCreatedToastMessage;

  String get totalPlants;

  String get orderedOn;

  String get deliveryDate;

  String get expectedDeliveryDate;

  String get expectedDeliveryQty;

  String get quantityLeft;

  String get sowingDate;

  String get expectedSowingDate;

  String get userDetails;

  String get downloadContract;

  String get name;

  String get email;

  String get phoneNumber;

  String get fathersName;

  String get gender;

  String get dateOfBirth;

  String get landmmark;

  String get district;

  String get city;

  String get state;

  String get degree;

  String get fieldOfStudy;

  String get farmingExperience;

  String get totalLandInAcres;

  String get dripSystem;

  String get soilType;

  String get refferedBy;

  String get otherFarmDetails;

  String get addressLine1;

  String get addressLine2;

  String get settings;

  String get executiveDetails;

  String get executiveName;

  String get executiveEmail;

  String get executivePhoneNumber;

  String get userNotFound;

  String get orderSeedlingsToViewTasks;
}
