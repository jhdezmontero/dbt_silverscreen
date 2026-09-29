-- models/stanging/stg_movie_catalogue.sql 

with source as (
    select * from {{ source('silverscreen', 'movie_catalog') }}
),

cleaned as (
    select 
        movie_id,
        movie_title,
        
        -- 1. Convert release date from 'DD.MM.YYYY' to 'YYYY-MM-DD' date format
        try_to_date(release_date, 'DD.MM.YYYY') as release_date,
        
        -- 2. Handle missing genres for specific movies and fallback to 'Unknown'
        case 
            when lower(movie_title) = 'bad boys: ride or die' then 'Action'
            when lower(movie_title) = 'mufasa: the lion king' then 'Animation'
            else coalesce(genre, 'Unknown')
        end as genre,
        
        -- 3. Standardize 'Disney' and 'Walt Disney' to 'Walt Disney Pictures'
        case 
            when trim(regexp_replace(studio, '\\.+$', '')) in ('Disney', 'Walt Disney') then 'Walt Disney Pictures'
            else trim(regexp_replace(studio, '\\.+$', '')) 
        end as studio,
        
        -- 4. Replace null minutes by splitting the movie_id by underscore and taking the last part
        coalesce(
            minutes, 
            cast(split_part(movie_id, '_', -1) as integer)
        ) as minutes

    from source
)

select * from cleaned