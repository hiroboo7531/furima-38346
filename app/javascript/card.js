const pay = () => {
  // Payjp.setPublicKey("PAY.JPテスト公開鍵); 

//  復習のため 
//  console.log("フォーム送信時イベント発火");
//  };  
// ここにconsole.logでページ読み込み時発火するか確認
 

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

  //復習のため 
  //   console.log("フォーム送信時イベント発火");
  //   });
  // };
  // これでフォーム送信時イベント発火を確認

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_send_info[number]"),      
      exp_month: formData.get("order_send_info[exp_month]"),
      exp_year: `20${formData.get("order_send_info[exp_year]")}`,
      cvc: formData.get("order_send_info[cvc]"),
    }; // フォーム情報はコンソールで確認   後で復習、手順を見返すようの記述

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
//後で復習、手順を見返すようのデバッグ 
//         console.log(token)
//       }
//     });
//   });
// };トークンを確認


        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        // debugger;    後で復習、手順を見返すようのデバッグ 
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);