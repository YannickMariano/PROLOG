Pour lancer le code et savoir le suspect:
1- swipl -q -t main enquete.pl
2- ex: crime (john, vol).

Pour lancer le code pour savoir les suspect:
1- swipl enquete.pl
2- findall(S, suspect(S), Liste).