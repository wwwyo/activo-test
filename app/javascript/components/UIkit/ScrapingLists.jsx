import React, {useState} from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';
import RowComponent from './RowComponent';

const useStyles = makeStyles({
  table: {
    minWidth: 650,
  },
});

const ScrapingLists = (props) => {
  const classes = useStyles();
  const organizations = props.data_scraping.organizations;
  const jobs = props.data_scraping.jobs;
  
  return (
    <TableContainer component={Paper}>
      <Table className={classes.table} size="small">
        <TableHead>
          <TableRow>
            <TableCell />
            <TableCell>Organization</TableCell>
            <TableCell>Job</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {organizations.map((organization, idx) => (
            <RowComponent 
              idx={idx} 
              jobs={jobs} 
              key={organization.url} 
              organization={organization} 
            />
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}

export default ScrapingLists;