import React from 'react';
import Header from './UIkit/Header';
import ScrapingLists from './UIkit/ScrapingLists';

const Index = (props) => {
  return (
    <>
      <Header />
      <main>
        <ScrapingLists data_scraping={props}/>
      </main>
    </>
  )
}

export default Index;