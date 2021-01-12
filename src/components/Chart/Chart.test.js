import React from 'react';
import { shallow, configure } from 'enzyme';
import { findByTestAtrr } from "../../../utils/index";

import Adapter from "enzyme-adapter-react-16";
import Chart from './Chart';

configure({ adapter: new Adapter() });

// describe('MyComponent', () => {
//   it('should render correctly in "debug" mode', () => {
//     const component = shallow(<Chart/>);
  
//     expect(component).toMatchSnapshot();
//   });
// });


describe("Chart", () => {
    describe("chart test", () => {
      let wrapper;
      beforeEach(() => {
        const props = {
            data:{
                confirmed:1,
                recovered:2,
                deaths:3,
                lastUpdate:4
            }
        };
        wrapper = shallow(<Chart {...props} />);
      });
  
      it("should render chart", () => {
        const cardComponent = findByTestAtrr(wrapper, "chart");
        // expect(cardComponent.length).toBe(3);
        expect(cardComponent).toMatchSnapshot();
      });
    });
  });