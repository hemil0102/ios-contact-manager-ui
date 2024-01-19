# ios-contact-manager-ui
# 연락처 관리 프로그램 토이 프로젝트

> **연락처 관리 프로그램** <br>
>
> 프로젝트 소개: SeSAC 토이 프로젝트 - 연락처 관리 프로그램   
> 프로젝트 기간: 2023.01.02 ~ 2023.01.19

## 팀원 소개
| <img src="https://github.com/tasty-code/ios-rock-scissor-paper/assets/63277563/129dca38-b8b6-401e-893d-5a6ba5e0f927.png" width="200"> | <img src="https://github.com/jane1choi/ios-juice-maker/assets/63277563/7fbc1d13-79fa-41ab-9bd4-452da98b0094.png" width="200"> |
|:----------:|:---------:|
| **Hoi** | **Harry** |
| [@happykwon](https://github.com/happykwon) |  [@hemil0102](https://github.com/hemil0102)) | 
<br>

## 구현 요구 사항
### Step 1-1 모델타입 구현
아래 내용 고려하여 Model 타입을 구현합니다.
연락처 관리앱은 사용자로부터 이름, 연락처, 나이에 대한 정보를 전달받습니다.
연락처를 관리하기 위해 필요한 기능은 아래와 같습니다.
- 연락처 보기
- 연락처 추가
- 연락처 삭제
- 연락처 변경(optional)
### Step 1-2 TableView의 사용

### Step 2 - 연락처 추가 기능 구현
- 추가기능을 구현하기 전에 동작에 대한 UML 을 작성하여 PR에 추가합니다.(2023.10.12 수정)
- 클래스 다이어그램, 액티비티 다이어그램, 시퀀스 다이어그램 중 필요한 UML을 선택하여 작성합니다.
- 연락처 목록 화면의 우상단 버튼을 통해 연락처 추가 화면에 진입할 수 있습니다.
- 오토 레이아웃과 스택뷰를 활용하여 화면을 레이아웃합니다.
- 각 필드에 맞는 키보드 종류를 지정합니다.
- 취소 버튼을 선택하면 정말 취소할 것인지 묻도록합니다.
- 저장 버튼을 선택하면 입력한 정보가 올바르게 입력되었는지 확인하도록 합니다.

### Step 3 - 연락처 삭제 / Cell Layout / Dynamic Type
- 필수 테이블뷰의 셀을 스와이프하여 삭제하는 메뉴를 보이고, 실제로 삭제할 수 있도록 구현합니다.
- 아래 기능 중 모두 구현하기에 시간이 부족하다면 구현하고 싶은 기능을 우선적으로 구현해보세요.
- 검색기능 통해 연락처 목록 내의 특정 연락처만 테이블뷰에 남길 수 있도록 구현해 주세요.
- Cell을 사용자정의하여 원하는 레이아웃으로 표현하도록합니다. (예시와 똑같지 않아도 됩니다.)
- Dynamic Type을 활용하여 시스템 설정에 따라 앱 글자 크기가 변경될 수 있도록 구현해주세요.

### Bonus STEP
- 해외 연락처 입력
    - 위 STEP2의 입력 방법으로는 한국의 전화번호 형식만 표현할 수 있습니다.
국제전화 및 해외 전화번호 입력 형식을 고민하고 구현해보세요.
예시: +82 10-2323-4545
국가번호(ex. +82) 입력시 뒤에 자동으로 공백이 추가됩니다.
+821023234545 입력시 +82 10-2323-4545로 나타납니다.
+8201023234545 입력시 +82 (0) 10-2323-4545로 나타납니다.
그 외 표현 규칙은 스스로 정하고 구현해보세요.
- 연락처 정보 변경
    - 연락처 목록에서 연락처를 선택하면 Step2의 연락처 추가 화면과 동일한 화면이 나옵니다. (단. 상단의 title 은 기존 연락처 로 변경합니다.)
연락처 추가 화면 의 이름, 나이, 연락처 UITextfield에는 사용자가 변경을 위해 선택한 연락처의 정보가 입력되어있습니다.
모든 정보가 올바르게 입력되었다면 저장 버튼을 선택했을 때 이전 화면으로 돌아가고, 새로 입력한 연락처 정보가 반영됩니다

## 폴더 구조
```swift
├── README.md
└── ios-contact-manager-ui
    ├── Controller
    │   ├── AddContactViewController.swift
    │   ├── AppDelegate.swift
    │   ├── ContactListViewController.swift
    │   ├── SceneDelegate.swift
    │   └── mockJson.json
    ├── Enum
    │   ├── JsonParsingError.swift
    │   └── TextFieldError.swift
    ├── Extension
    │   ├── PhoneNumberFormatter.swift
    │   └── UIViewController + Extension.swift
    ├── Model
    │   ├── Contact.swift
    │   └── JsonDecoder.swift
    ├── View
    │   ├── Assets.xcassets
    │   │   ├── AccentColor.colorset
    │   │   │   └── Contents.json
    │   │   ├── AppIcon.appiconset
    │   │   │   └── Contents.json
    │   │   └── Contents.json
    │   └── Base.lproj
    │       ├── LaunchScreen.storyboard
    │       └── Main.storyboard
    ├── ios-contact-manager-ui
    │   └── Info.plist
    └── ios-contact-manager-ui.xcodeproj
        ├── project.pbxproj
        ├── project.xcworkspace
        │   ├── contents.xcworkspacedata
        │   ├── xcshareddata
        │   │   ├── IDEWorkspaceChecks.plist
        │   │   └── swiftpm
        │   │       └── configuration
        │   └── xcuserdata
        │       └── harryho.xcuserdatad
        │           └── UserInterfaceState.xcuserstate
        └── xcuserdata
            ├── harryho.xcuserdatad
            │   ├── xcdebugger
            │   │   └── Breakpoints_v2.xcbkptlist
            │   └── xcschemes
            │       └── xcschememanagement.plist
            └── kwontaeho.xcuserdatad
                └── xcschemes
                    └── xcschememanagement.plist

```
### 구현사항
1. `AddContactViewController`: 새 연락처 추가 기능을 하는 뷰 컨트롤러. 사용자 입력을 `UITextField`로 받고, `AddContactDelegate` 프로토콜을 통해 연락처 목록 업데이트.
2. `ContactListViewController`: 연락처 목록을 표시하는 뷰 컨트롤러. `UITableView`와 UISearchController를 사용하여 연락처 검색 및 표시.
3. `TextFieldError`: 연락처 입력 필드 오류를 정의하는 열거형. 각 오류 유형별 메시지 제공.
4. `phoneNumberFormatter`: 전화번호 포맷팅을 위한 확장. 문자열에서 숫자 추출 및 한국식 전화번호 포맷 적용.
5. `JsonDecoder`: JSON 데이터 로드 및 디코딩을 위한 구조체. 제네릭을 사용하여 다양한 데이터 타입 처리.
6. `Alert 구현`: UIAlertController를 사용한 경고 메시지 표시. `presentAlert`및 `presentAlertWithCancel` 메서드로 구현.
7. `화면 전환 구현`: `addContactButtonTapped` 메서드를 통한 `AddContactViewController`로의 화면 전환. `UINavigationController`를 사용한 모달 방식 적용.
8. `UITextFieldDelegate 구현`: `UITextField` 동작 관리.전화번호 입력 필드의 자동 포맷팅 기능 제공.
9. `JsonDecoder 사용`: 로컬 JSON 파일에서 연락처 데이터 로드 및 파싱. `loadData` 메서드로 `Contact` 배열 변환 및 초기 데이터 로드.

## 구동 화면
구현 내용 | 구동 영상1 (삭제) | 구동 영상2(검색 및 삭제)
-- | -- | -- 
구동화면 | ![Simulator Screen Recording - iPhone 15 Pro Max - 2024-01-18 at 16 20 53](https://github.com/tasty-code/ios-contact-manager-ui/assets/83139316/60e683d8-c7f2-46dd-b89e-72b65c6e983b) | ![Simulator Screen Recording - iPhone 15 Pro Max - 2024-01-18 at 16 21 48](https://github.com/tasty-code/ios-contact-manager-ui/assets/83139316/617015fc-7b27-4160-9ec0-13be9f62a436) |

