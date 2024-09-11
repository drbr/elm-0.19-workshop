module Main exposing (main)

-- NOTE: Make sure to follow the instructions in the README for part3
-- to install the elm/browser package before running elm make!
--
-- FYI: 👇 You can see our new `Article` module in `src/Article.elm`

import Article
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


initialModel =
    { tags = Article.tags
    , selectedTag = ""
    , allArticles = Article.feed
    }



-- UPDATE


update msg model =
    if msg.description == "ClickedTag" then
        { model | selectedTag = msg.data }

    else
        model



-- VIEW


view model =
    let
        filterFunc article =
            if model.selectedTag == "" then
                True

            else
                List.member model.selectedTag article.tags

        articles =
            List.filter filterFunc
                model.allArticles

        feed =
            List.map viewArticle articles
    in
    div [ class "home-page" ]
        [ viewBanner
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] feed
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags model
                        ]
                    ]
                ]
            ]
        ]


viewArticle article =
    div [ class "article-preview" ]
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        , span [] [ text "Read more..." ]
        ]


viewBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ] [ text "conduit" ]
            , p [] [ text "A place to share your knowledge." ]
            ]
        ]


viewTag selectedTagName tagName =
    let
        otherClass =
            if tagName == selectedTagName then
                "tag-selected"

            else
                "tag-default"

        clickMsg =
            { description = "ClickedTag"
            , data =
                if selectedTagName == tagName then
                    ""

                else
                    tagName
            }
    in
    button
        [ class ("tag-pill " ++ otherClass)
        , onClick clickMsg
        ]
        [ text tagName ]


viewTags model =
    div [ class "tag-list" ] (List.map (viewTag model.selectedTag) model.tags)



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
