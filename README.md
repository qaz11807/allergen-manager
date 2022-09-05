# 說明

## 需求
```
目前接到一個新需求，是要開發一個全新的APP MVP (Minimum Viable Product)產品，放到市場上觀察狀況，如果市場反應不錯將會列入產品線，而你被指派為主要的 backend developer 來開發實作此產品。

APP的主打的對象為 "急性且嚴重過敏的使用者"，可用來設定並管理 "過敏物" 以及 "管理過敏藥" 的應用APP。

除了設定自訂的過敏原外，當急性過敏發作時，可以馬上叫出緊急聯絡人的相關資訊並全屏請求其他人幫忙聯絡。

後端的開發者需要做一個純API server，需要串接的前端合作夥伴為APP端。

後端需實現的主要功能：

使用者可以註冊登入，
使用者需要註冊的資訊(信箱、密碼、姓名、生日、額外資訊)
能夠建立使用者的過敏原(過敏原名稱)並對其做增刪查改，能夠從過敏原關聯到相對應的藥物。
能夠對過敏藥物(藥物名稱、藥物廠牌、過期日、額外註記)做增刪查改，需要建立過敏物藥名、以及可讓用戶儲存過敏藥圖片。
能夠對緊急聯絡人(聯絡人姓名、聯絡人手機、額外註記)做增刪查改、並且能夠讓用戶自定義聯絡人優先聯絡順序的排序。
```
---
## 功能需求
 - 核心功能:
   - 過敏原、過敏藥物管理
     - 增刪查改
     - 設定關聯
   - 緊急聯絡人
     - 增刪查改
     - 自訂排序 
 - 共通功能:
   - 會員系統
     - 登入
     - 登出
     - 註冊

---
## 資料庫設計

資料庫關係圖:
 - [DBdiagram](https://dbdiagram.io/d/623acfc7bed6183873e17934)
 - 說明： 
    - allergen: 過敏原
    - medicines: 抗過敏藥
    - allergen_medicines: allergen 與 antiallergic 關聯表
    - profile: 個人資料
    - contact: 緊急聯絡人
    - user: 使用者
    - image: 圖片

---
## 商業邏輯

**原型: [figma](https://www.figma.com/file/WJPJrByScynsbYTditpq2t/Kdan?node-id=20%3A978)**

---
## API設計

[![Run in Postman](https://run.pstmn.io/button.svg)](https://documenter.getpostman.com/view/19978532/VUxYq3sA)

| env name | value |
| ------ | ------ |
| host | https://allergen-manager-center.herokuapp.com/ |
| client_id | WhUru9KY77r0kOCL3GhfapxuhU3XhralUbtHNBghBbA |
| client_secret | 7zmvS6KXJyD7xn3-O0usyj3dUQwNSJsdqLH2lZ0rpdQ |


