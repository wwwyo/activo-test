import React, { useState } from 'react';
import Box from '@material-ui/core/Box';
import Checkbox from '@material-ui/core/Checkbox';
import Collapse from '@material-ui/core/Collapse';
import IconButton from '@material-ui/core/IconButton';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';

const RowComponent = (props) => {
  const jobs = props.jobs;
  const organization = props.organization;
  const organizationId = props.idx
  
  const [isCheckMark, setIsCheckMark] = useState(organization.is_checked);
  const [isOpen, setIsOpen] = useState(false);
  
  return (
    <>
    <TableRow>
      <TableCell>
        <Checkbox
          checked={isCheckMark}
          onClick={() => setIsCheckMark(!isCheckMark)}
        />
      </TableCell>
      <TableCell component="th" scope="row">
        <a href={organization.url}>
          {organization.name}
        </a>
      </TableCell>
      <TableCell>
        <div display="flex">
          {jobs[organizationId].length}件
          <IconButton size="small" onClick={() => setIsOpen(!isOpen)}>
            {isOpen ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
          </IconButton>
        </div>
      </TableCell>
    </TableRow>
    <TableRow>
      <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={6}>
        <Collapse in={isOpen} timeout="auto" unmountOnExit>
          <Box margin={1}>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Title</TableCell>
                  <TableCell>Date</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {jobs[organizationId].map((job) => (
                  <TableRow key={job.url}>
                    <TableCell>
                      <a href={job.url}>{job.title}</a>
                    </TableCell>
                    <TableCell>{job.event_date}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </Box>
        </Collapse>
      </TableCell>
    </TableRow>
    </>
  )
}

export default RowComponent;