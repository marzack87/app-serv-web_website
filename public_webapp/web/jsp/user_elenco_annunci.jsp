<%-- 
    Document   : user_modifica
    Created on : 17-feb-2014, 12.26.48
    Author     : marco
--%>

<%@page import="gestione_annuncio.Apartment"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
            String from = "";
            if (request.getAttribute("from") != null) {
                from = (String) request.getAttribute("from");
            }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% if (from.equals("search")){ %>
            <title>Scheda Annuncio</title>
        <% } else if (from.equals("user")){ %>
            <title>Elenco Annunci</title>
        <% } %>
        <link rel="stylesheet" type="text/css" href="/public_webapp/style-sheets/style.css">
    </head>
    <body>
        
        <% if (from.equals("search")){ %>
            <%@ include file="/WEB-INF/jspf/navigation_bar.jspf" %>
        <% } else if (from.equals("user")){ %>
            <%@ include file="/WEB-INF/jspf/navigation_bar_logged.jspf" %>
        <% } %>
        
        
        
        <% 
            
            ArrayList<Apartment> apartments_list = new ArrayList<Apartment>();
            if (request.getAttribute("apartments_list") != null) {
                apartments_list = (ArrayList<Apartment>) request.getAttribute("apartments_list");
            }
            
            if (apartments_list.size() == 0){
                
            %>
            <br>
            <br>
            <br>
            <br>
            <br>
            <div class="centered text_big">NESSUN ANNUNCIO PRESENTE</div>
            <%
                
            } else {
            
                for(int i = 0; i < apartments_list.size(); i++){
                    String indirizzo = apartments_list.get(i).address;
                    indirizzo += ", " + apartments_list.get(i).civico;
                    indirizzo += " - " + apartments_list.get(i).citta;
                    
                    String piano = apartments_list.get(i).n_piano;
                    if (piano.equals("-1")){
                        piano = "Seminterrato";
                    } else if (piano.equals("0")) {
                        piano = "Piano Terra";
                    } else {
                        piano = piano + "° Piano";
                    }
                    
                    String ascensore = "";
                    if (Integer.parseInt(apartments_list.get(i).n_piano) > 0){
                        switch (Integer.parseInt(apartments_list.get(i).ascensore)) {
                            case 0:
                                ascensore = "(senza ascensore)";
                                break;
                            case 1:
                                ascensore = "(con ascensore)";
                                break;   
                        }
                    }
                    
                    String tipo = "";
                    switch (Integer.parseInt(apartments_list.get(i).tipologia)) {
                        case 0:
                            tipo = "Appartamento, " + piano + " " + ascensore;
                            break;
                        case 1:
                            tipo = "Villetta";
                            break;
                        case 2:
                            tipo = "Casa Indipendente";
                            break;    
                    }
                    
                    String descrizione = "";
                    switch (Integer.parseInt(apartments_list.get(i).tipo_cucina)) {
                        case 0:
                            descrizione = "Cucina Abitabile";
                            break;
                        case 1:
                            descrizione = "Cucinotto";
                            break;   
                    }
                    
                    descrizione += ", " + apartments_list.get(i).bagni;
                    if (Integer.parseInt(apartments_list.get(i).bagni) == 1) {
                         descrizione += " Bagno";
                    } else {
                         descrizione += " Bagni";
                    }
                    
                    descrizione += ", " + apartments_list.get(i).camere_letto;
                    if (Integer.parseInt(apartments_list.get(i).camere_letto) == 1) {
                         descrizione += " Camera da Letto";
                    } else {
                         descrizione += " Camere da Letto";
                    } 
                    
                    if (Integer.parseInt(apartments_list.get(i).garage) == 1) {
                        descrizione += ", Garage";
                    }
                    
                    if (Integer.parseInt(apartments_list.get(i).terrazzo) == 1) {
                        descrizione += ", Terrazzo";
                    }
                    
                    String posti = apartments_list.get(i).posti_totali;
                    if (Integer.parseInt(apartments_list.get(i).posti_totali) == 1) {
                        posti += " Posto letto in totale, ";
                    } else {
                        posti += " Posti letto in totale, ";
                    }
                    posti += apartments_list.get(i).posti_liberi;
                    if (Integer.parseInt(apartments_list.get(i).posti_liberi) == 1) {
                        posti += " libero. ";
                    } else {
                        posti += " liberi. ";
                    }
                    posti += apartments_list.get(i).prezzo + " €/mese per posto letto.";
                    
                    String spese = "";
                    
                    if (Integer.parseInt(apartments_list.get(i).spese_acqua) == 1) {
                        spese += " AQUA";
                    }
                    
                    if (Integer.parseInt(apartments_list.get(i).spese_gas) == 1) {
                        if (!spese.equals("")) spese += ", ";
                        spese += " GAS";
                    }
                    
                    if (Integer.parseInt(apartments_list.get(i).spese_luce) == 1) {
                        if (!spese.equals("")) spese += ", ";
                        spese += " LUCE";
                    }
                    
                    if (Integer.parseInt(apartments_list.get(i).spese_cond) == 1) {
                        if (!spese.equals("")) spese += ", ";
                        spese += " CONDOMINIALI";
                    }
                    
                    if (Integer.parseInt(apartments_list.get(i).ness_spesa) == 1) {
                        spese = "NESSUNA SPESA INCLUSA";
                    } else {
                        spese = "SPESE INCLUSE:" + spese;
                    }
                    
                    String images = "";
                    boolean first = true;
                    for (String image : apartments_list.get(i).img_url)
                    {
                        if (image.equals("\n")) continue;
                        if (first){
                            first = false;
                        } else {
                            images += "#";
                        }
                        images += image;
                    }
        %>
        
        <div class="centered">
            <div class="text_very_big">
                <%= tipo %>
            </div>
            <div class="text_big">
                <%= indirizzo %>
            </div>
            <br>
            <div class="italic">
                <%= descrizione %>
                <br>
                <%= posti %>
            </div>
            <div class="text_small">
                <%= spese %>
            </div>
            
            
            <% if (apartments_list.get(i).img_url.size() > 0){ %>
            
            <br>
            <applet code="visione_foto.viewApplet.class" archive="/public_webapp/applet/SearchApplet.jar" width="400" height="400">
                <param name="parameter" value="<%= images %>">
                <div class="text_red text_big">Attenzione! Java non supportato dal browser</div>
            </applet>
            
            <% } else { %>
            
            <img class="no_photo" src ="/public_webapp/multimedia/photos/no_foto.png">
            
            <% } %>
            
            <br>
            <% if (from.equals("user")){ %>
            
            <a class="text_big button inLine" href="#">Modifica</a>
            <a class="text_big button inLine bg_red" href="#">Elimina</a>
            
            <% } %>
            <br>
            <br>
            
        </div>
            
        <hr>
        
        <%      }
            }
        %>
    </body>
</html>
