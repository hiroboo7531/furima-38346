// window.addEventListener('load', () => {
//   console.log("OK");
// });

window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  // const 変数名 = 変数に入れる値;
  console.log(priceInput)
   priceInput.addEventListener("input", () => {
    // 金額を入力するたびに、イベント発火するようにaddEventListenerを使用するよ
    // 入力があるたびにイベント発火を起こしたいため、右のようにinputというイベントを使用するよ。画面で確認してみて、右がコードを打つ際の段取り console.log("イベント発火")改行 const inputValue = priceInput.value;改行 console.log(inputValue);
    // 続いて、商品出品ページで金額を入力し、コンソール上に金額が表示されるか確認。

// innerHTMLを使用して、販売手数料や利益計算結果を表示できるように innerHTMLは、HTML要素の書き換えを行うことができるよ。
     const addTaxDom = document.getElementById("add-tax-price");
//      console.log(priceInput.innerHTML);
     addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    //  Math.round("入力した金額をもとに販売手数料を計算する処理")
     const addPofitDom = document.getElementById("profit");
//      console.log(priceInput.innerHTML);
     addPofitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
//        販売手数料や利益計算の処理は、Math.floorメソッドを用いて実装、floorをroundだと四捨五入、ceilだと切り上げ
 })
});

// ブラウザのコンソールは、command + option + Jで開くことができる

// <%= f.text_field :price, class:"price-input", id:"item-price", placeholder:"例）300" %>入力する金額は税込総額
/* <span id='add-tax-price'></span>円 出品ページの税の記述 */
/* <span id='profit'></span>円 税を除いた金額のコード*/

// idセレクタを取得する場合はdocument.getElementById("id名")を使用します。
// document.getElementById("id名")は、id名を指定してHTMLの要素を取得するメソッドです。
// const priceInput = document.getElementById("金額を入力する場所のid");
// 次に、console.logを記述して、定義した変数にinput要素が格納されているか確認をします。

// 【例】item_price.js
// const priceInput = document.getElementById("金額を入力する場所のid");
// console.log(priceInput);
// 商品出品ページでブラウザのコンソールを開き、以下のようなinput要素が表示されるか確認をします。