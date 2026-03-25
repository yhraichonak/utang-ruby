@regression @automated @core @general
Feature: About Screen

  AS1-220
  - As a user, I want to have an About screen (See Linked Confluence Page for Most recent field values)
  - The About modal needs to be able to grow vertically (as content is added) and scroll when necessary.

  List of fields in the About modal:
  - (Section Header) "Application Info"
  App Name
  App Version
  Build
  UDI
  Copyright
  Patent Number

  - (Section Header) "Technical Support"
  Online User Guide Link to Online user Guide
  Phone Support US (24/7)
  Phone Support UK (24/7)
  Email Support

  - (Section Header) "Device Info"
  Device Name (field and value shown only when available)
  Operating System
  Browser Type
  Browser Version

  - (Section Header) "Manufactured By"
  Manufacturer Symbol (left aligned), utang address (right aligned)
  Date of Manufacture Symbol (left aligned), Date of Manufacture in format YYYY/MM/DD (right aligned)

  - (Section Header) "EU Authorized Representative"
  EC REP Icon (left aligned), EU address (right aligned)

  - EULA including Link
  - (utang ONE Logo) (CE Mark)

  AS1-434
  - Updates include:
  - Refer to linked confluence "Application Info" section for the following:
  - UDI and Manufacture Date must match (in mobile About Screen screen shot attached - 16D20180731 and 2018/07/31)
  Note: Per Lillie: I know we are always reluctant to specify a day because we do not know, but the regulation gives us no choice. We have arbitrarily picked the date the UDI is generated as the manufacturer date'.UDI will be auto generated. The manufacture date in the generated UDI will be used to update the Manufacture Date. For example, if the generated UDI = 20180812 the Manufacture Date also needs to be updated to read 2018/08/12.
  - Copyright should read copyright symbol space 2018

  - Refer to mobile Screen Shot for the following:
  - Device Info section should come after the Application Info section and before the Technical Support section.

  - Refer to linked Confluence Page "Technical Support" section for the following:
  - Phone US to read (Phone US Toll-free (24/7) 1-877-258-5869
  - UK phone to be added (Phone UK (24/7) 800: 0-800-088-5520
  - CA phone to be added (Phone CA (24/7) 1-210-805-0444, Option 2
  - AU phone to be added (Phone AU (24/7) 039832 2222)

  - Refer to Linked Confluence page "Manufactured By" section for the following:
  - Update to new SA address
  - Update Manufactured By date to read YYYY/MM/DD (see Lillie note above)

  - Refer to Linked Confluence Page "EU Authorized Representative" section for the following:
  - Add Emergo phone number (31-70-345-8570)

  - New 9/26 Add Section Header "AU Authorized Representative" section below EU
  - New 9/26 Add Cardioscan name + Address, right aligned (no image included)
  Cardioscan Services Pty Ltd.
  293 Camberwell Rd. Suite 301
  Victoria 3124 Australia

  - Refer to Mobile screen shots - section (logo, CE Mark and Rx symbol) for the following:
  - Update CE mark with attached "CE Mark"
  - Add "Rx symbol" to the right of the CE Mark
  - Add the text "US ONLY" under the Rx Symbol

  MIG-374
  - Update About Screen:
  - https://utang.atlassian.net/wiki/spaces/PD/pages/496107521/About+Screen+-+Current+Information
  - Update UDI for utang ONE Web 3.0 as per UDI link above.
  UDI: +B153200310/$$7300/16D20190219L
  Date of Manufacture: 2019/02/19
  - Hauge should be spelled "Hague"

  AS1-681
  - Update About Screen:
  - Instructions for Use Icon
  - Under Technical Support
  - Add "Instructions for Use" image/asset to the "Online User Guide" row per https://utang.atlassian.net/wiki/spaces/PD/pages/496107521/About+Screen+-+Current+Information
  - Display image/asset to the right of the "Online User Guide" text - TBD - either image first, text second or vice versa

  - Add AU Authorized Rep section
  - Add Section Header "AU Authorized Representative" section below EU Authorized Rep
  - Add Cardioscan name + Address, right aligned (no image)
  Cardioscan Services Pty Ltd.
  293 Camberwell Rd. Suite 301
  Victoria 3124 Australia

  AS1-7324
  - Online User Guide
  - The name of the link should be updated to read "User Guides and Training."
  - The updated link for Web is:  https://utang.lpages.co/webtraining/

  AS1-7335
  - Update EU
  - The EU section header will be updated to read "EU Authorized Representative & Importer"
  - The EU address should be updated to:
  MedEnvoy Global B.V.
  Prinses Margrietplantsoen 33 - Suite 123
  2595 AM The Hague
  The Netherlands
  - There will not be a phone number below the address.
  - This address should be right aligned within the EU Authorized Representative & Importer section.
  - The size of the address should not change.

  - Add UK
  - There will be a new section below the "EU Authorized Representative & Importer" labeled "UK Responsible Person & Importer".
  - The UK address will be:
  MedEnvoy UK Limited
  85, Great Portland Street, First Floor
  London, W1W 7LT
  United Kingdom
  - This address should be right aligned within the UK Responsible Person & importer section.
  - The size of the address should be the same as the EU one.

  AS1-7338
  - Add Importer Icon
  - The importer Icon (below) will need to be added under the EU Authorized Representative & Importer section and the UK Responsible & Importer section.
  - The importer icon will be aligned directly below the EC|REP icon for the EU Authorized Representative & Importer section.
  - The importer icon for the UK Responsible & Importer section will be left aligned within the section.

  AS1-1021
  Web 2.0 UDI: +B15320030/$$7200/16D20181205E
  Manufacturer date: 2018/12/05

  AS1-1362
  UDI: +B15320030/$$7300/16D20190219K
  date of Manufacture: 2019/02/19

  AS1-1671
  UDI:  +B153200310/$$7310/16D20190603J
  Mfg. Date:  2019/06/03

  UDI: +B153200310/$$7320/16D20191101E
  Mfg. Date: 2019/11/01

  AS1-2736
  UDI: +B153200310/$$7321/16D202002219
  Mfg. Date:  2020/02/21

  AS1-2841
  patch version 3.2.1.1

  AS1-2924
  UDI: +B153200310/$$7330/16D20200417G
  Mfg. Date: 2020/04/17

  AS1-3244
  UDI: +B153200310/$$7332/16D20200706J
  Mfg. Date: 2020/07/06

  AS1-3743
  UDI: +B153200310/$$7341/16D20201215F
  Mfg. Date: 2020/12/15

  AS1-3838
  UDI:  +B153200310/$$7342/16D20210208I
  Mfg. Date:  2021/02/08

  AS1-3861
  Description
  UDI:  +B153230010/$$7343/16D20210219L
  Mfg. Date:  2021/02/19

  AS1-4067
  UDI:  +B153200310/$$7344/16D20210513J
  Mfg. Date:  2021/05/13

  AS1-4106
  UDI :  +B153200310/$$7345/16D20210604L
  Mfg. Date:  2021/06/04

  AS1-4068
  UDI :  +B153200310/$$7345/16D20210604L
  Mfg. Date:  2021/06/04

  AS1-4408
  UDI:  +B153200310/$$7351/16D20210902J
  Mfg. Date:  2021/09/02

  AS1-4408
  UDI: +B153200310/$$7351/16D20210902J
  Mfg: 2021/09/02

  AS1-4685
  UDI: +B153200310/$$7352/16D20211118K
  Mfg: 2021/11/18

  AS1-4899
  UDI: +B153200310/$$7353/16D20220117K
  Mfg: 2022/01/17

  AS1-4844
  UDI: +B153200310/$$7400/16D202201128
  Mfg Date: 2022/01/12

  AS1-5088
  UDI: +B153200310/$$7354/16D20220223J
  Mfg Date: 2022/02/23

  AS1-6324
  UDI: +B153200310/$$7402/16D20220908N
  Mfg. Date: 2022/09/08

  AS1-6594
  UDI: +B153301030/$$7410/16D202211019
  Mfg. Date: 2022/11/01

  AS1-6749
  +B153301030/$$7403/16D20221205G
  mfg date: 2022/12/05

  AS1-7366
  +B153301030/$$7411/16D20230508L
  Mfg date: 2023/05/08

  TestRail Id: C181125

  Jira Issues: AS1-220, AS1-434, AS1-681, AS1-1021, AS1-889, AS1-1362, MIG-374, AS1-1671, AS1-1739, AS1-2111, AS1-2333, AS1-2736, AS1-2841, AS1-2924
  Additonal Jira Issues: AS1-3156, AS1-3138, AS1-3244, AS1-3536, AS1-3743, AS1-3861, AS1-4067, AS1-4106, AS1-4408, AS1-4685, AS1-4899, AS1-4844, AS1-5088
  Additional Jira Issues: AS1-6324, AS1-6594, AS1-6749, AS1-7366, AS1-7324, AS1-7335, AS1-7338

  Jira Bugs/Defects: AS1-1361, AS1-2574
@critical @TMS:181125
Scenario: About Screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on About link
  Then I should see About screen window
  And I should see Application Info section
  And I should see "App Name" in "Application Info" section
  And I should see "App Version" in "Application Info" section
  And I should see "Build Number" in "Application Info" section
  And I should see "UDI" in "Application Info" section
  And I should see App Version as "[env.APP_VERSION]"

  And I should see UDI as "[props.MD_UDI]"
  And I should see "Copyright" in "Application Info" section
  And I should see "Patent Number" in "Application Info" section
  And I should see Technical Support section
  And I should see Online User Guide link in Technical Support section
  And I should see "Phone US Toll-free (24/7)" in "Technical Support" section
  And I should see "Phone UK (24/7)" in "Technical Support" section
  And I should see "Phone CA (24/7)" in "Technical Support" section
  And I should see "Phone AU (24/7)" in "Technical Support" section
  And I should see "Email Support" in "Technical Support" section
  And I should see Device Info section
  And I should see "Operating System" in "Device Info" section
  And I should see "Browser Type" in "Device Info" section
  And I should see "Browser Version" in "Device Info" section
  And I should see Manufactured By section
  And I should see "Manufacturer Symbol" in "Manufactured By" section
  And I should see "utang address" in "Manufactured By" section
  And I should see "Date of Manufacture Symbol" in "Manufactured By" section
  And I should see "YYYY/MM/DD of Manufacture" in "Manufactured By" section
  And I should see Manufacture Date as "[props.MD_BUILD_DATE]"
  And I should see EU Authorized Representative section
  And I should see "EC REP Icon" in "EU Authorized Representative" section
  And I should see "EU address" in "EU Authorized Representative" section
  And I should see UK Responsible Person & Importer
  And I should see AU Authorized Representative section
  And I should see "Cardioscan Services Pty Ltd" in "AU Authorized Representative" section
  And I should see "AU address" in "AU Authorized Representative" section
  And I should see "+61 3 9832 2222" in "AU Authorized Representative" section
  And I should see "0 3 9832-2222" in "AU Authorized Representative" section
  And I should see EULA link
  And I should see utang ONE logo
  And I should see CE Mark image - 2797
  And I should see Rx Symbol image
  And I click on Done button on the About screen
  Then I should see the patient list screen

  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on Logout link
  Then I should see the login screen
