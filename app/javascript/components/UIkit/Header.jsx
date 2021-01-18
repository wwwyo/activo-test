import React from 'react';
import {makeStyles} from '@material-ui/styles';
import AppBar from '@material-ui/core/AppBar';
import HeaderMenus from "./HeaderMenus";
import Toolbar from "@material-ui/core/Toolbar";

const useStyles = makeStyles({
  root: {
    flexGrow: 1,
  },
  headerMenus: {
    margin: '0 0 0 auto'
  },
  menuBar: {
    backgroundColor: "#fff",
    color: "#000",
  },
  toolBar: {
    margin: "0 auto",
    maxWidth: 1024,
    width: "90%"
  },
})

const Header = () => {
  const classes = useStyles();

  return(
    <header className={classes.root}>
      <AppBar position="fixed" className={classes.menuBar} >
        <Toolbar className={classes.toolBar}>
          <div className={classes.headerMenus}>
            <HeaderMenus />
          </div>
        </Toolbar>
      </AppBar>
    </header>
  )
}

export default Header;