# 간헐적 단식 어플


### 🔗 Link

| [📍 GitHub](https://github.com/LIMMIHEE/intermittent_fasting) | [🎨 Figma](https://www.figma.com/file/d4DQJV3AOz3e003xTfCtz2/%EA%B0%84%ED%97%90%EC%A0%81-%EB%8B%A8%EC%8B%9D-%EC%96%B4%ED%94%8C-%EB%94%94%EC%9E%90%EC%9D%B8?type=design&node-id=0%3A1&mode=design&t=9ZgwMqcWumKCuW9l-1) |
| --- | --- |

<br/>
<br/>


---

## 🛎️ 기능

- 단식 시간 기록
    - 이후 단식 종료시 시작 시간 조절 가능
    - 목표 단식 시간 설정 가능
- 과거 기록 확인
    - 어떤 식사를 하였는지 혹은 어떤 일이 있었는지에 대한 기록 가능
    - 기록 삭제 가능
- 단식 분석
    - 최근 7가지의 단식 기록에 대한 평균값 확인 가능
        - 평균 공복 시간
        - 평균 달성률
- 다크모드 설정
- 안드로이드, IOS 지원

<br/>
<br/>

## 📚 상세 설명

**기획의도**

다른 앱들의 경우 원하는 시간대를 마음대로 선택하지 못하고 부분 유료화되어있어 사용하면서 불편함을 느꼈습니다.

동시에 단식 시작 때에 식사 일기도 적음으로써 오늘 먹은 식단이 어땠는지

과식하지는 않았는지에 대한 정보를 기록과 함께 볼 수 있으면 더욱 오랫동안 간헐적 단식을 지속하고

자신의 약점이나 불안함을 보완할 수 있을 것이라고 생각하여 해당 앱을 제작하게 되었습니다.

<br/>

**사용 대상**

자신의 단식 시간에 대한 기록과 분석, 날마다의 식단 및 단식에 대한 기록을 한 번에 진행하고자 하는 유저

<br/>

**기대 효과**

이 앱을 사용함으로써, 긴 단식 기간을 선택하여 진행도를 확인하고자 하는 유저는 따로 돈을 들이지 않고 진행이 가능합니다.

또한 식단이나 단식에 대한 기록을 진행하며 자신의 부족한 점이나 더 나아가면 좋을 점 등을 기록하여 이후 보완에 도움이 될 수 있으며, 분석 탭을 통해 최근 달성률 등으로 부족한 점 혹은 잘한 점을 확인하여 더욱 나아갈 의지를 다질 수 있습니다.


<br/>
<br/>

## 💡 느낀 점( 배운 점 )

- `SQFilte` 사용 방법을 익히게 되었습니다.
- `themeNotifier` 를 통한 다크 모드 적용 방법과 `DesignSystem`의 중요성, 적용 방법을 깨닫게 되었습니다.
- 기존 `Provider.of` 만을 사용한 방법이 아닌 select, read 등에 대한 `Provider` 사용 방법을 익힐 수 있었습니다.
- `showModalBottomSheet` 의 상태 변경 방법과
이미 시트가 띄워져 있는 상태에서 `showSnackBar` 띄우는 방법을 알 수 있었습니다.
- `fl_chart` 패키지를 통한 차트 사용에 대한 경험을 할 수 있었습니다.



<br/>
<br/>



## 📷  앱 화면

![001](https://github.com/LIMMIHEE/intermittent_fasting/assets/48482259/6e51874a-4d63-4fed-8288-46e8f6291385)
![002](https://github.com/LIMMIHEE/intermittent_fasting/assets/48482259/728e3cdd-17a7-45c5-bfa2-c8cdc57f4f76)
![003](https://github.com/LIMMIHEE/intermittent_fasting/assets/48482259/b5cf8cba-4dc8-432c-a498-886badaa8fc2)
