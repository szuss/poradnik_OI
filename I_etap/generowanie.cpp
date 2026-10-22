// program generujacy napis skladajacy sie z malych liter o dlugosci n (n nalezy do [1, 200]) oraz ciag liczb zmiennoprzecinkowych z przedzialu [1, 1'000) o dlugosci m (m nalezy do [2, 500])
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    // to dajeny tylko raz na poczatku
    random_device rd; 
    mt19937 gen(rd());
    // ustawiamy zakres z jakiego losujemy i typ danych
    uniform_int_distribution<int> jakas_nazwa(1, 200); // w nawiasie <> dajemy jaki typ liczb całkowitych ma to być np int lub long long (można to wykorzystać do generowania znaków wtedy dajem zakres [0, 27] i będziemy dodawać do 'a')
    // generujemy dlugosc napisu
    int n = jakas_nazwa(gen); 
    cout << n << endl;
    string s = "";
    // ustawiamy zakres losowania na kody ASCII od 'a' do 'z'
    uniform_int_distribution<int> alfabet('a', 'z');
    for (int i = 0; i < n; i++) {
        s.push_back(alfabet(gen));
    }
    cout << s << endl;
    // ustawimy zakres losowania dla m
    uniform_int_distribution<int> dlam(2, 500);
    int m = dlam(gen);
    cout << m << endl;
    // ustawiamy zakres dla [1, 1'000)
    uniform_real_distribution<long double> zmienno(1, 1'000); // w <> dajemy typ danych zmiennoprzecinkowych np dubble lub long dubble
    for (int i = 0; i < m; i++) 
        cout << zmienno(gen) << ' ';
}