class KeySendDataHost {
  //! Submit Residence
  static int residenceTypeId = 0;
  static String residenceName = '';
  static String residenceDescription = '';
  static String residenceAdditionalInfo = '';
  static String residenceAddress = '';
  static int residenceRoomCount = 0;
  static int residenceMaximumCapacity = 0;
  static int residenceMinimumCapacity = 0;
  static int residencePrice = 0;
  static int province = 0;
  static int city = 0;
  static String checkInTime = '';
  static String checkOutTime = '';
  static List<int> regulations = [];
  static List<int> options = [];
  static double lat = 0;
  static double long = 0;
  static List<String> imageList = [];
  static int idHostSubmitResidence = 0;

  //!calculate data List
  static List<String> sendDates = [];
  static List<int> defaultPrice = [];
  static List<int> percentPrice = [];
  static List<String> idDate = [];

  static int detailId = 0;

//! Submit Parking
  static int typeParking = 0;
  static String description='';
  static int capacityParking=0;
  static String checkInTimeParking='';
  static String checkOutTimeParking='';
  static bool isCheckedParking=false;

}
