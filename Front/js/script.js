async function verifier() {
    const suspect = document.getElementById("suspect").value;
    const crime = document.getElementById("crime").value;

    try {
    const response = await fetch(`http://localhost:8000/api?suspect=${suspect}&crime=${crime}`);
    const data = await response.json();

    const resultDiv = document.getElementById("result");
    if (data.result === "guilty") {
        resultDiv.innerHTML = "✅ " + suspect + " est <b>coupable</b> de " + crime;
        resultDiv.style.color = "red";
    } else {
        resultDiv.innerHTML = "❌ " + suspect + " est <b>innocent</b> pour " + crime;
        resultDiv.style.color = "green";
    }
    } catch (err) {
    alert("Erreur de connexion au serveur Prolog !");
    }
}